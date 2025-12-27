import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      bottomNavigationBar: _bottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TITLE
              const Text(
                "Admin Panel",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "CounselMate Institute",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // STATS CARD
              _statsCard(),

              const SizedBox(height: 25),

              // GRID CARDS
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.05,
                ),
                children: [
                  _actionCard(
                    icon: Icons.person_add,
                    title: "Add Student",
                    subtitle: "Add a new student profile",
                  ),
                  _actionCard(
                    icon: Icons.person_add_alt_1,
                    title: "Add Mentor",
                    subtitle: "Onboard a new mentor",
                  ),
                  _actionCard(
                    icon: Icons.remove_red_eye,
                    title: "View Students",
                    subtitle: "See all student records",
                  ),
                  _actionCard(
                    icon: Icons.people_alt,
                    title: "View Mentors",
                    subtitle: "Manage mentor profiles",
                  ),
                  _actionCard(
                    icon: Icons.history,
                    title: "Audit Logs",
                    subtitle: "Review system activity",
                  ),
                  _actionCard(
                    icon: Icons.settings,
                    title: "Settings",
                    subtitle: "Configure institute settings",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Stats Card UI
  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statsItem(Icons.person, "Total Students", "1,234"),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          _statsItem(Icons.person_add, "Total Mentors", "56"),
        ],
      ),
    );
  }

  // 📌 Each Stats Item
  Widget _statsItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.black87),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.black54)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 📌 Action Card Grid Item
  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.black87),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Bottom Navigation Bar
  Widget _bottomNav() {
    return BottomNavigationBar(
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Panel",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
