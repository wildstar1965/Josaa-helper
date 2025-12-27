import 'package:flutter/material.dart';
import '../login/select_role_screen.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9DD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10),

                /// 🔥 MAIN TITLE
                const Center(
                  child: Text(
                    "App Overview & Features",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                /// ⭐ USER ROLES CARD
                _sectionCard(
                  title: "User Roles",
                  children: [
                    const Text(
                      "CounselMate supports a variety of user roles...",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 18),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: const [
                        _roleBox(
                          icon: Icons.shield,
                          title: "Super Admin,\nInstitute Admin",
                        ),
                        _roleBox(
                          icon: Icons.school,
                          title: "Mentor,\nPaid Student",
                        ),
                        _roleBox(
                          icon: Icons.person,
                          title: "Free Student,\nGuest User",
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 24),

                /// ⭐ KEY FEATURES
                _sectionCard(
                  title: "Key Features",
                  children: [
                    _featureRow(Icons.login, "Login & Signup"),
                    _featureRow(Icons.admin_panel_settings, "Role-Based Access Control"),
                    _featureRow(Icons.account_tree, "Multi-Institute Support"),
                    _featureRow(Icons.verified_user, "JWT Token Security"),
                    _featureRow(Icons.history, "Audit Logging"),
                  ],
                ),

                const SizedBox(height: 24),

                /// ⭐ FREE vs PAID USERS
                _sectionCard(
                  title: "Free vs. Paid Users",
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: _infoBox(
                            label: "Free Users",
                            description: "Basic chatbot access,\nGeneral info",
                            icon: Icons.person_outline,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _infoBox(
                            label: "Paid Users",
                            description: "Full access,\nRecommendations,\nPDF uploads",
                            icon: Icons.star,
                            highlight: true,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 40),

                /// 🔥 GET STARTED BUTTON
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2922D),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SelectRoleScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------------------
/// 🔷 REUSABLE COMPONENTS
/// ---------------------------

class _sectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _sectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _roleBox extends StatelessWidget {
  final IconData icon;
  final String title;

  const _roleBox({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDD5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.orange),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _featureRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: Colors.orange, size: 22),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}

class _infoBox extends StatelessWidget {
  final String label;
  final String description;
  final IconData icon;
  final bool highlight;

  const _infoBox({
    required this.label,
    required this.description,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFFFE4D6) : const Color(0xFFFFF3E2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.orange),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
