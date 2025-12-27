// lib/screens/home/home_student.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../models/user.dart';

import '../chats/chat_screen.dart';
import '../chats/premium_lock_popup.dart';

class HomeStudentPage extends StatelessWidget {
  const HomeStudentPage({super.key});

  static const Color primary = Color(0xFFEE8C2B);
  static const Color bg = Color(0xFFF9F6F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      bottomNavigationBar: _buildBottomNav(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ---------------- HEADER ----------------
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF7EDE4),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(36),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 26),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome, Student!",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "All premium features are unlocked.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.brown.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Verified badge
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(Icons.verified, size: 28, color: primary),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ---------------- IMPORTANT DATES ----------------
                    _importantDatesCard(),

                    const SizedBox(height: 20),

                    // ---------------- PREMIUM TOOLS ----------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: const Text(
                        "Your Premium Tools",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _toolCard(
                            title: "AI Counsellor",
                            subtitle: "Full access",
                            icon: Icons.smart_toy,
                            bgColor: const Color(0xFFD7ECE6),
                            iconColor: const Color(0xFF5D9C94),
                          ),
                          _toolCard(
                            title: "Recommendations",
                            subtitle: "Personalized list",
                            icon: Icons.recommend,
                            bgColor: const Color(0xFFFAF0D6),
                            iconColor: const Color(0xFFC79E3A),
                          ),
                          _toolCard(
                            title: "Upload JEE PDF",
                            subtitle: "Get started",
                            icon: Icons.upload_file,
                            bgColor: const Color(0xFFFDE7D6),
                            iconColor: primary,
                          ),
                          _toolCard(
                            title: "College Info",
                            subtitle: "Explore details",
                            icon: Icons.school,
                            bgColor: const Color(0xFFE8F3E8),
                            iconColor: const Color(0xFF2E8F4A),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- IMPORTANT DATES CARD ----------------
  Widget _importantDatesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event_available_rounded, color: primary),
                const SizedBox(width: 10),
                const Text(
                  "Important Dates",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            _dateRow("JUN", "28", "Certificate Submission",
                "Last day for document verification online."),
            const SizedBox(height: 14),
            _dateRow("JUL", "05", "Result Publication",
                "First round seat allocation results.")
          ],
        ),
      ),
    );
  }

  // ---------------- DATE ROW ----------------
  Widget _dateRow(String month, String day, String title, String subtitle) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(month,
                  style: const TextStyle(
                      color: primary, fontWeight: FontWeight.w700)),
              Text(day,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        Container(
          width: 1.2,
          height: 48,
          color: primary.withOpacity(0.2),
          margin: const EdgeInsets.only(right: 12),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700)),
              Text(subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        )
      ],
    );
  }

  // ---------------- TOOL CARD ----------------
  Widget _toolCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            radius: 26,
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              )),
        ],
      ),
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _buildBottomNav(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser;

    return BottomNavigationBar(
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey.shade600,
      showUnselectedLabels: true,
      currentIndex: 0,

      onTap: (index) {
        if (index == 0) return; // Dashboard already active

        if (index == 1) {
          // --- CHAT PRESSED ---
          if (user?.role == UserRole.freeStudent) {
            showDialog(
              context: context,
              builder: (_) => const PremiumLockPopup(),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            );
          }
        }

        if (index == 2) {
          // Profile screen later
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize_outlined),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
