// lib/screens/student/student_dashboard.dart
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Palette tuned to your mockup
    const bg = Color(0xFFFAF7F5);
    const peach = Color(0xFFFCE7D9);
    const peachAccent = Color(0xFFF4A04A); // primary orange
    const deepText = Color(0xFF211613);
    const mutedText = Color(0xFF9A7F67);
    const surface = Colors.white;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            children: [
              // HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome back,",
                          style: TextStyle(fontSize: 18, color: mutedText),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Ankit!",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: deepText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // notification icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none, color: Colors.black87),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // FEATURE CARDS (two large rounded cards side-by-side)
              Row(
                children: [
                  Expanded(
                    child: _FeatureBlock(
                      backgroundColor: peach,
                      chipColor: peachAccent.withOpacity(0.12),
                      iconColor: peachAccent,
                      title: "AI Counsellor",
                      subtitle: "Basic Access",
                      selected: true,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _FeatureBlock(
                      backgroundColor: surface,
                      chipColor: peachAccent.withOpacity(0.08),
                      iconColor: peachAccent,
                      title: "College Info",
                      subtitle: "Basic Access",
                      selected: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // PREMIUM FEATURES card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
                ),
                child: Column(
                  children: [
                    // Title + upgrade
                    Row(
                      children: [
                        const Expanded(
                          child: Text("Premium Features",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text("Upgrade",
                              style: TextStyle(fontSize: 14, color: peachAccent, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 14),

                    // list items
                    _PremiumItem(
                      icon: Icons.stars,
                      title: "Recommendations",
                      subtitle: "Personalized for you",
                    ),
                    const SizedBox(height: 10),
                    _PremiumItem(
                      icon: Icons.upload_file,
                      title: "Upload JEE PDF",
                      subtitle: "Unlock insights",
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // UNLOCK PREMIUM CTA (big rounded)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: peachAccent,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(color: peachAccent.withOpacity(0.25), blurRadius: 18, offset: const Offset(0,6)),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.workspace_premium, color: Colors.white),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Unlock Premium",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Get personalized recommendations and unlock all features to secure your dream college!",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    // button inside CTA (white pill)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: peachAccent,
                          shape: const StadiumBorder(),
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                        ),
                        child: const Text("Upgrade Now", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // bottom navigation (simple)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: peachAccent,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

/// Big rounded feature block widget
class _FeatureBlock extends StatelessWidget {
  final Color backgroundColor;
  final Color chipColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool selected;

  const _FeatureBlock({
    required this.backgroundColor,
    required this.chipColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    // makes a large rounded square with a top-centered circular chip
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: selected ? 10 : 6, offset: const Offset(0,4)),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // chip (circle) near top
          Positioned(
            top: 14,
            child: Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: chipColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chat_bubble_outline, color: iconColor),
            ),
          ),

          // text content lower down
          Positioned(
            bottom: 16,
            left: 12,
            right: 12,
            child: Column(
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF201613))),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: Color(0xFF9A7F67))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium list row
class _PremiumItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PremiumItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F0F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.grey.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Color(0xFF9A7F67))),
              ],
            ),
          ),
          Icon(Icons.lock_outline, color: Colors.grey.shade500),
        ],
      ),
    );
  }
}
