import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Text("Admin Panel",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text("CounselMate Institute"),

          SizedBox(height: 20),

          Row(
            children: [
              _statsCard("Total Students", "1,234"),
              SizedBox(width: 12),
              _statsCard("Total Mentors", "56"),
            ],
          ),

          SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _tile(Icons.person_add, "Add Student", "Add a new student profile"),
              _tile(Icons.group_add, "Add Mentor", "Onboard a new mentor"),
              _tile(Icons.school, "View Students", "See all student records"),
              _tile(Icons.supervisor_account, "View Mentors", "Manage mentor profiles"),
              _tile(Icons.history, "Audit Logs", "Review system activity"),
              _tile(Icons.settings, "Settings", "Configure institute settings"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: adminNav(1),
    );
  }

  Widget _statsCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _tile(IconData icon, String title, String subtitle) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

Widget adminNav(int index) {
  return BottomNavigationBar(
    currentIndex: index,
    selectedItemColor: AppTheme.primary,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Panel"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ],
  );
}
