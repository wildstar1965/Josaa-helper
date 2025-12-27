import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../login/select_role_screen.dart';
import '../home/home_student.dart';
import '../home/home_free.dart';
import '../admin/admin_panel.dart';
import '../mentor/mentor_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), checkLoginState);
  }

  void checkLoginState() {
    final auth = Provider.of<AuthService>(context, listen: false);

    // NOT LOGGED IN → Go to Role Select
    if (auth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SelectRoleScreen()),
      );
      return;
    }

    // FREE STUDENT
    if (auth.isFreeStudent) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeFree()),
      );
      return;
    }

    // PREMIUM STUDENT
    if (auth.isPaidStudent) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeStudentPage()),
      );
      return;
    }

    // ADMIN
    if (auth.isAdmin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminPanelScreen()),
      );
      return;
    }

    // MENTOR
    if (auth.isMentor) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MentorDashboard()),
      );
      return;
    }

    // DEFAULT → If no match
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SelectRoleScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "CounselMate",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
