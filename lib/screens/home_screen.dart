import 'package:flutter/material.dart';
import 'study_materials_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2469A7),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: const [
              Icon(Icons.school, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Civil PSC',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.notifications_none, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          children: [
            // Top welcome banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4C8DFF), Color(0xFF6AC8FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to CIVILPSC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your trusted partner for a smarter PSC preparation journey.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Features title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Feature cards grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.05,
                  children: [
                    _HomeFeatureCard(
                      emoji: '📚',
                      title: 'Study Materials',
                      subtitle: 'PDF notes & short note',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const StudyMaterialsHome(),
                          ),
                        );
                      },
                    ),
                    _HomeFeatureCard(
                      emoji: '🧠',
                      title: 'Quiz',
                      subtitle: 'Quick MCQ practice',
                      onTap: () => _showComingSoon(context),
                    ),
                    _HomeFeatureCard(
                      emoji: '📂',
                      title: 'PYQ – Subjects',
                      subtitle: 'Subject wise PYQ',
                      onTap: () => _showComingSoon(context),
                    ),
                    _HomeFeatureCard(
                      emoji: '📄',
                      title: 'PYQ Exams',
                      subtitle: 'Full previous papers',
                      onTap: () => _showComingSoon(context),
                    ),
                    _HomeFeatureCard(
                      emoji: '📅',
                      title: 'Daily Exam',
                      subtitle: 'Timed mini tests',
                      onTap: () => _showComingSoon(context),
                    ),
                    _HomeFeatureCard(
                      emoji: '🎮',
                      title: 'Battle',
                      subtitle: '1 vs 1 live quiz',
                      onTap: () => _showComingSoon(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Bottom navigation
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: scheme.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Contact'),
            BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Pro'),
          ],
        ),
      ),
    );
  }

  static void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon')),
    );
  }
}

// ------------- Feature Card (emoji center) -------------

class _HomeFeatureCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeFeatureCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 34),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
