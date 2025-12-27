import 'package:flutter/material.dart';
import '../core/theme.dart';

Widget featureCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required Widget trailing,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.primary.withOpacity(.20),
            child: Icon(icon, color: AppTheme.primary),
          ),
          SizedBox(width: 12),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        SizedBox(height: 6),
        Text(subtitle, style: TextStyle(color: AppTheme.textSecondary)),
        SizedBox(height: 12),
        Align(alignment: Alignment.centerRight, child: trailing),
      ],
    ),
  );
}
