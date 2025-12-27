import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class FreeSignupScreen extends StatefulWidget {
  const FreeSignupScreen({super.key});

  @override
  State<FreeSignupScreen> createState() => _FreeSignupScreenState();
}

class _FreeSignupScreenState extends State<FreeSignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool showPass = false;
  bool showConfirmPass = false;
  bool loading = false;

  Color get primary => const Color(0xFFEE8C2B);
  Color get bgLight => const Color(0xFFF8F7F6);
  Color get borderColor => const Color(0xFFE7DBCF);
  Color get hintColor => const Color(0xFF9A734C);
  Color get textPrimary => const Color(0xFF1B140D);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create Free Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Join CounselMate for smart AI counseling.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: hintColor),
                  ),

                  const SizedBox(height: 36),

                  _label("Name"),
                  _inputField(
                    controller: name,
                    icon: Icons.person_outline,
                    hint: "Enter your full name",
                  ),

                  const SizedBox(height: 22),

                  _label("Email"),
                  _inputField(
                    controller: email,
                    icon: Icons.mail_outline,
                    hint: "Enter your email",
                  ),

                  const SizedBox(height: 22),

                  _label("Password"),
                  _passwordField(
                    controller: password,
                    hint: "Create a password",
                    visible: showPass,
                    onToggle: () => setState(() => showPass = !showPass),
                  ),

                  const SizedBox(height: 22),

                  _label("Confirm Password"),
                  _passwordField(
                    controller: confirmPassword,
                    hint: "Confirm your password",
                    visible: showConfirmPass,
                    onToggle: () =>
                        setState(() => showConfirmPass = !showConfirmPass),
                  ),

                  const SizedBox(height: 30),

                  // SIGNUP BUTTON
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                      await _handleSignup(auth);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      elevation: 4,
                    ),
                    child: loading
                        ? const CircularProgressIndicator(
                        color: Colors.white)
                        : const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _altButton(Icons.mail_outline, "Continue with Gmail"),
                  const SizedBox(height: 10),
                  _altButton(
                      Icons.smartphone_outlined, "Continue with Phone Number"),

                  const SizedBox(height: 30),

                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: hintColor, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
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

  // ------------------ SIGNUP LOGIC ------------------

  Future<void> _handleSignup(AuthService auth) async {
    final n = name.text.trim();
    final e = email.text.trim();
    final p = password.text.trim();
    final cp = confirmPassword.text.trim();

    if (n.isEmpty || e.isEmpty || p.isEmpty || cp.isEmpty) {
      _toast("All fields are required");
      return;
    }

    if (p != cp) {
      _toast("Passwords do not match");
      return;
    }

    setState(() => loading = true);

    try {
      await auth.signupFree(n, e, p);

      _toast("Account created! Please login.");
      Navigator.pop(context); // Back to login
    } catch (err) {
      _toast(err.toString());
    }

    setState(() => loading = false);
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------------- UI COMPONENTS ----------------

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600)),
  );

  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: hintColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: hintColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: !visible,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: hintColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _altButton(IconData icon, String text) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: textPrimary),
      label: Text(text, style: TextStyle(color: textPrimary)),
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
