// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teja/screens/overview/overview_screen.dart';

import 'services/auth_service.dart';
import 'screens/login/select_role_screen.dart'; // update path if needed
import 'core/theme.dart'; // optional: your theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CounselMate',
        theme: ThemeData.light(),
        home: const OverviewScreen(),
      ),
    );
  }
}
