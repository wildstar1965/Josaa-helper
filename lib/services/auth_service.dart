// lib/services/auth_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class AuthService extends ChangeNotifier {
  // LOCAL EMULATOR URL:
  // If testing on Android emulator use 10.0.2.2 instead of 127.0.0.1:
  // "http://10.0.2.2:5001/teja-64a6c/asia-south1/api"
  static const String baseUrl =
      "http://10.0.2.2:5001/teja-64a6c/asia-south1/api";

  // PRODUCTION URL (after deploy):
  // static const String baseUrl =
  //    "https://asia-south1-teja-64a6c.cloudfunctions.net/api";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AppUser? _currentUser;
  bool _isLoading = false;




  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  // Role checks
  bool get isAdmin => _currentUser?.role == UserRole.admin;
  bool get isMentor => _currentUser?.role == UserRole.mentor;
  bool get isPaidStudent => _currentUser?.role == UserRole.paidStudent;
  bool get isFreeStudent => _currentUser?.role == UserRole.freeStudent;

  // ---------------- INTERNAL HELPERS ----------------
  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> _saveTokens(String access, String refresh) async {
    await _storage.write(key: "accessToken", value: access);
    await _storage.write(key: "refreshToken", value: refresh);
  }

  Future<String?> _getAccessToken() => _storage.read(key: "accessToken");
  Future<String?> _getRefreshToken() => _storage.read(key: "refreshToken");

  Future<void> _clearTokens() async {
    await _storage.delete(key: "accessToken");
    await _storage.delete(key: "refreshToken");
  }

  // ---------------------- LOGIN ----------------------
  /// Logs user in, stores tokens, then fetches /auth/me to populate full profile.
  Future<AppUser> login(String email, String password) async {
    _setLoading(true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email.trim(),
          "password": password.trim(),
        }),
      );

      if (response.statusCode != 200) {
        // backend should return { error: "..." }
        final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        throw AuthException(body['error'] ?? 'Login failed');
      }

      final data = jsonDecode(response.body);

      final access = data["accessToken"] as String?;
      final refresh = data["refreshToken"] as String?;

      if (access == null || refresh == null) {
        throw AuthException("Auth server did not return tokens");
      }

      await _saveTokens(access, refresh);

      // Now fetch canonical user profile from /auth/me (authorized)
      final profileJson = await _authorizedGet("/auth/me");
      final user = _fromBackendUser(profileJson as Map<String, dynamic>);
      _currentUser = user;
      notifyListeners();

      return user;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------- SIGNUP FREE ----------------------
  Future<void> signupFree(String name, String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/signup/free");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      print("SIGNUP RESPONSE: ${response.body}");
      throw data["error"] ?? "Signup failed";

    }
  }


  // ---------------------- LOGOUT ----------------------
  Future<void> logout() async {
    _setLoading(true);

    try {
      // Optionally call backend to revoke refresh token
      final refresh = await _getRefreshToken();
      if (refresh != null) {
        try {
          await http.post(
            Uri.parse("$baseUrl/auth/logout"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"refreshToken": refresh}),
          );
        } catch (_) {
          // ignore network errors during logout
        }
      }

      await _clearTokens();
      _currentUser = null;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------- AUTO LOGIN ----------------------
  Future<bool> tryAutoLogin() async {
    final access = await _getAccessToken();
    if (access == null) return false;

    try {
      final data = await _authorizedGet("/auth/me");
      _currentUser = _fromBackendUser(data as Map<String, dynamic>);
      notifyListeners();
      return true;
    } catch (_) {
      // try refreshing if access token expired
      final newAccess = await _refreshToken();
      if (newAccess == null) return false;
      try {
        final data = await _authorizedGet("/auth/me");
        _currentUser = _fromBackendUser(data as Map<String, dynamic>);
        notifyListeners();
        return true;
      } catch (_) {
        return false;
      }
    }
  }

  // ----------------- REFRESH TOKEN LOGIC -----------------
  Future<String?> _refreshToken() async {
    final refresh = await _getRefreshToken();
    if (refresh == null) return null;

    final resp = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refresh}),
    );

    if (resp.statusCode != 200) {
      await _clearTokens();
      return null;
    }

    final data = jsonDecode(resp.body);
    final newAccess = data["accessToken"] as String?;
    final newRefresh = data["refreshToken"] as String?;
    if (newAccess == null || newRefresh == null) {
      await _clearTokens();
      return null;
    }

    await _saveTokens(newAccess, newRefresh);
    return newAccess;
  }

  // ---------- AUTHORIZED REQUEST WITH AUTO TOKEN RENEW ----------
  Future<dynamic> _authorizedGet(String path) async {
    return _authorizedRequest(() async {
      final access = await _getAccessToken();
      return http.get(
        Uri.parse("$baseUrl$path"),
        headers: {
          "Authorization": "Bearer ${access ?? ''}",
          "Content-Type": "application/json"
        },
      );
    });
  }

  Future<dynamic> _authorizedRequest(Future<http.Response> Function() requestFn) async {
    http.Response res = await requestFn();

    if (res.statusCode == 401) {
      final newAccess = await _refreshToken();
      if (newAccess == null) throw AuthException("Session expired");

      // retry original request (requestFn will pick up new access token)
      res = await requestFn();
    }

    if (res.statusCode != 200) {
      final body = res.body.isNotEmpty ? jsonDecode(res.body) : {};
      throw AuthException(body['error'] ?? "Request failed: ${res.statusCode}");
    }

    return jsonDecode(res.body);
  }

  // ----------------- USER MAPPING -----------------
  AppUser _fromBackendUser(Map<String, dynamic> json) {
    // backend should return { email, name, role } from /auth/me
    final roleValue = json["role"] is String ? json["role"] as String : (json["role"]?.toString() ?? "");
    return AppUser(
      email: json["email"] ?? "",
      name: json["name"] ?? (json["email"] ?? ""),
      role: _mapRole(roleValue),
    );
  }

  UserRole _mapRole(String role) {
    switch (role) {
      case "admin":
        return UserRole.admin;
      case "mentor":
        return UserRole.mentor;
      case "paidStudent":
        return UserRole.paidStudent;
      case "freeStudent":
        return UserRole.freeStudent;
      default:
        return UserRole.student;
    }
  }
}
