import 'package:flutter/material.dart';
import '../../core/theme.dart';

class MentorDashboard extends StatelessWidget {
  MentorDashboard({super.key});

  final students = [
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
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text("Welcome back, Mentor!"),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: _infoCard("12", "My Students", Icons.people)),
              const SizedBox(width: 12),
              Expanded(child: _infoCard("3", "Sessions Today", Icons.video_call)),
              const SizedBox(width: 12),
              Expanded(child: _infoCard("View", "Analytics", Icons.bar_chart)),
            ],
          ),

          const SizedBox(height: 20),

          const Text("Your Students",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          ...students.map((s) => _studentTile(s)),
        ],
      ),
    );
  }

  Widget _infoCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label),
        ],
      ),
    );
  }

  Widget _studentTile(Map data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 22, backgroundColor: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  data["status"],
                  style: TextStyle(color: data["color"]),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
