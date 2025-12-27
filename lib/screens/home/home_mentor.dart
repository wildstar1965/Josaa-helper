import 'package:flutter/material.dart';
import '../../core/theme.dart';

class MentorHomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {"name": "Ananya Sharma", "status": "Session Scheduled", "color": Colors.green},
    {"name": "Rohan Verma", "status": "Awaiting Response", "color": Colors.orange},
    {"name": "Priya Patel", "status": "Docs Submitted", "color": Colors.blue},
    {"name": "Sameer Khan", "status": "Session Scheduled", "color": Colors.green},
    {"name": "Neha Reddy", "status": "Awaiting Response", "color": Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Text("Dashboard",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text("Welcome back, Mentor!"),

          SizedBox(height: 20),

          Row(
            children: [
              _smallCard("12", "My Students", Icons.people),
              SizedBox(width: 12),
              _smallCard("3", "Sessions Today", Icons.video_call),
              SizedBox(width: 12),
              _smallCard("View", "Analytics", Icons.bar_chart),
            ],
          ),

          SizedBox(height: 20),
          Text("Your Students",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),

          ...students.map((s) => _studentTile(s)),
        ],
      ),
      bottomNavigationBar: mentorNav(0),
    );
  }

  Widget _smallCard(String value, String title, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primary),
            SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _studentTile(Map student) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundColor: Colors.grey.shade200),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                Text(student["status"],
                    style: TextStyle(color: student["color"])),
              ],
            ),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

Widget mentorNav(int index) {
  return BottomNavigationBar(
    currentIndex: index,
    selectedItemColor: AppTheme.primary,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calendar"),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ],
  );
}
