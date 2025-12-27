import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../models/user.dart';

// role screens
import '../admin/admin_panel.dart';
import '../home/home_student.dart';
import '../home/home_free.dart';
import '../mentor/mentor_dashboard.dart';

// new free signup screen
import '../free/free_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool rememberMe = false;
  bool showPassword = false;
  bool loading = false;

  // Colors matching your Tailwind variables
  Color get primary => const Color(0xFFEE8C2B);
  Color get bgLight => const Color(0xFFF8F7F6);
  Color get borderColor => const Color(0xFFE7DBCF);
  Color get hintColor => const Color(0xFF9A734C);
  Color get titleColor => const Color(0xFF1B140D);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    "CounselMate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                      height: 1.02,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Welcome back! Please enter your details.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: hintColor),
                  ),

                  const SizedBox(height: 32),

                  // Email Label
                  _label("Email"),
                  const SizedBox(height: 8),
                  _inputField(
                    controller: email,
                    icon: Icons.mail_outline,
                    hint: "Enter your email",
                  ),

                  const SizedBox(height: 22),

                  // Password Label
                  _label("Password"),
                  const SizedBox(height: 8),
                  _passwordField(),

                  const SizedBox(height: 14),

                  // Remember + Forgot
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        activeColor: primary,
                        onChanged: (v) => setState(() => rememberMe = v!),
                      ),
                      Text("Remember Me", style: TextStyle(color: hintColor)),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Login Button
                  ElevatedButton(
                    onPressed: loading ? null : () => _handleLogin(auth),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      elevation: 6,
                    ),
                    child: loading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Continue with Gmail
                  _socialButton(
                    icon: Icons.mail_outline,
                    text: "Continue with Gmail",
                  ),
                  const SizedBox(height: 10),

                  // Continue with Phone
                  _socialButton(
                    icon: Icons.smartphone_outlined,
                    text: "Continue with Phone Number",
                  ),

                  const SizedBox(height: 22),

                  // Footer – Create Free Account
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: hintColor,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Create Free Account",
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const FreeSignupScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // LOGIN LOGIC
  // -------------------------------
  Future<void> _handleLogin(AuthService auth) async {
    if (email.text.isEmpty || password.text.isEmpty) {
      _toast("Email and password cannot be empty");
      return;
    }

    setState(() => loading = true);

    try {
      await auth.login(email.text.trim(), password.text.trim());
      final user = auth.currentUser!;
      if (!mounted) return;

      _navigateByRole(user.role);
    } catch (e) {
      _toast(e.toString());
    }

    setState(() => loading = false);
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // -------------------------------
  // ROLE NAVIGATION
  // -------------------------------
  void _navigateByRole(UserRole role) {
    Widget screen;

    switch (role) {
      case UserRole.admin:
        screen = AdminPanelScreen();
        break;
      case UserRole.mentor:
        screen = MentorDashboard();
        break;
      case UserRole.paidStudent:
        screen = const HomeStudentPage();
        break;
      default:
        screen = const HomeFree();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // -------------------------------
  // UI COMPONENTS
  // -------------------------------
  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Icon(icon, color: hintColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: hintColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: password,
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: InputBorder.none,
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => showPassword = !showPassword),
            child: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton({required IconData icon, required String text}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: titleColor),
      label: Text(text, style: TextStyle(color: titleColor)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
