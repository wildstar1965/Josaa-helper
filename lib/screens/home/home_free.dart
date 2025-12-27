// lib/screens/home/home_free.dart

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../chats/premium_lock_popup.dart'; // 🔥 ADD THIS IMPORT

class HomeFree extends StatelessWidget {
  const HomeFree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      bottomNavigationBar: _buildBottomNavBar(context), // 🔥 Pass context
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // -------------------------------
              // HEADER SECTION
              // -------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style:
                        TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        "Ankit!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.notifications_outlined, size: 28),
                ],
              ),

              const SizedBox(height: 25),

              // -------------------------------------
              // FEATURE CARDS
              // -------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _featureCard(
                    title: "AI Counsellor",
                    subtitle: "Basic Access",
                    icon: Icons.chat_bubble_outline_rounded,
                    bgColor: const Color(0xFFFEE8D2),
                  ),
                  _featureCard(
                    title: "College Info",
                    subtitle: "Basic Access",
                    icon: Icons.school_outlined,
                    bgColor: Colors.white,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // -------------------------------------
              // PREMIUM HEADER
              // -------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Premium Features",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Upgrade",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              _premiumFeature(
                title: "Recommendations",
                subtitle: "Personalized for you",
                icon: Icons.recommend_outlined,
              ),
              const SizedBox(height: 12),

              _premiumFeature(
                title: "Upload JEE PDF",
                subtitle: "Unlock insights",
                icon: Icons.picture_as_pdf_outlined,
              ),

              const SizedBox(height: 30),

              _unlockPremiumBanner(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================
  // FEATURE CARD WIDGET
  // =========================================
  Widget _featureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
  }) {
    return Container(
      width: 155,
      height: 150,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.85),
            radius: 28,
            child: Icon(icon, size: 28, color: AppTheme.primary),
          ),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          Text(subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }

  // =========================================
  // PREMIUM FEATURE ROW
  // =========================================
  Widget _premiumFeature({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFEDEDED),
            child: Icon(icon, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const Spacer(),
          Icon(Icons.lock_outline, color: Colors.grey.shade700),
        ],
      ),
    );
  }

  // =========================================
  // PREMIUM BANNER
  // =========================================
  Widget _unlockPremiumBanner() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Text(
            "🔓 Unlock Premium",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Get personalized recommendations and unlock all features to secure your dream college!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Center(
              child: Text(
                "Upgrade Now",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================
  // BOTTOM NAVIGATION — FREE USERS
  // =========================================
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      currentIndex: 0,

      onTap: (index) {
        if (index == 1) {
          // 🔥 FREE USERS → SHOW PREMIUM POPUP
          showDialog(
            context: context,
            builder: (_) => const PremiumLockPopup(),
          );
        }

        if (index == 2) {
          // PROFILE PAGE (ADD LATER)
        }
      },

      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: "Chats"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}
