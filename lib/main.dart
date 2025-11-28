import 'package:flutter/material.dart';

void main() {
  runApp(const CivilPSCApp());
}

class CivilPSCApp extends StatelessWidget {
  const CivilPSCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIVILPSC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
        ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        scaffoldBackgroundColor: const Color(0xFFF5F6FF),
        fontFamily: 'Roboto',
      ),
      home: const AuthGate(),
    );
  }
}

// demo user name
const String currentUserName = 'User Name';

/// ----------------------------------------------------------
/// AUTH GATE – LOGIN → OTP → HOME
/// ----------------------------------------------------------

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _otpSent = false;
  bool _loggedIn = false;
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    if (!_otpSent) {
      return PhoneLoginScreen(
        onOtpSent: (phone) {
          setState(() {
            _otpSent = true;
            _phoneNumber = phone;
          });
        },
      );
    }

    if (!_loggedIn) {
      return OtpVerifyScreen(
        phoneNumber: _phoneNumber,
        onVerified: () {
          setState(() {
            _loggedIn = true;
          });
        },
      );
    }

    return const MainShell();
  }
}

/// ----------------------------------------------------------
/// PHONE LOGIN SCREEN  (screenshot-style)
/// ----------------------------------------------------------

class PhoneLoginScreen extends StatefulWidget {
  final void Function(String phoneNumber) onOtpSent;

  const PhoneLoginScreen({super.key, required this.onOtpSent});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile number'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    widget.onOtpSent(phone); // later → Firebase OTP
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              // logo
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 56,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Civil PSC',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Professional Exam Preparation',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 28),

              // phone box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                child: Row(
                  children: [
                    const Text(
                      '+91',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 26,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // SEND OTP button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _handleSendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),
              const Text(
                'We will send an OTP to verify your phone number.\nStandard messaging rates may apply.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),

              const Spacer(),

              // bottom App Features (emoji row)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8FF),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Text(
                      'App Features',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _FeatureMini(emoji: '📚', label: 'Study Materials'),
                        _FeatureMini(emoji: '🧠', label: 'MCQ Tests'),
                        _FeatureMini(emoji: '📝', label: 'Model Exams'),
                        _FeatureMini(emoji: '⚡', label: 'Quick Prep'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureMini extends StatelessWidget {
  final String emoji;
  final String label;

  const _FeatureMini({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }
}

/// ----------------------------------------------------------
/// OTP VERIFY SCREEN
/// ----------------------------------------------------------

class OtpVerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onVerified;

  const OtpVerifyScreen({
    super.key,
    required this.phoneNumber,
    required this.onVerified,
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final otp = _otpController.text.trim();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the OTP'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    widget.onVerified(); // demo success
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: scheme.primary,
          foregroundColor: Colors.white,
          title: const Text('Verify OTP'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'OTP sent to +91 ${widget.phoneNumber}',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter 6-digit OTP',
                  counterText: '',
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: scheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Verify & Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------
/// MAIN SHELL – HOME + BOTTOM NAV
/// ----------------------------------------------------------

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final pages = const [
    HomePage(),
    Center(child: Text('Search coming soon')),
    Center(child: Text('Contact coming soon')),
    Center(child: Text('Pro area coming soon')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.phone_in_talk_outlined),
            selectedIcon: Icon(Icons.phone_in_talk),
            label: 'Contact',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.workspace_premium),
            label: 'Pro',
          ),
        ],
      ),
    );
  }
}

/// ----------------------------------------------------------
/// HOME PAGE  (Welcome + 6 emoji tiles)
/// ----------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FF),
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          title: Row(
            children: const [
              Icon(Icons.school, size: 24),
              SizedBox(width: 8),
              Text(
                'Civil PSC',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            WelcomeBanner(),
            SizedBox(height: 20),
            FeaturesTitle(),
            SizedBox(height: 10),
            FeaturesGrid(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Your trusted partner for a smarter PSC preparation journey.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FeaturesTitle extends StatelessWidget {
  const FeaturesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Features',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

/// ---------------- FEATURES GRID WITH EMOJIS ----------------

class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key});

  List<FeatureItem> _items() {
    return [
      FeatureItem(
        title: 'Study Materials',
        subtitle: 'PDF notes & short note',
        emoji: '📚',
        color: const Color(0xFFEAF0FF),
      ),
      FeatureItem(
        title: 'Quiz',
        subtitle: 'Quick MCQ practice',
        emoji: '🧠',
        color: const Color(0xFFFFF1E6),
      ),
      FeatureItem(
        title: 'PYQ – Subjects',
        subtitle: 'Subject wise PYQ',
        emoji: '📂',
        color: const Color(0xFFE7FFF2),
      ),
      FeatureItem(
        title: 'PYQ Exams',
        subtitle: 'Full previous papers',
        emoji: '📄',
        color: const Color(0xFFEAF8FF),
      ),
      FeatureItem(
        title: 'Daily Exam',
        subtitle: 'Timed mini tests',
        emoji: '📅',
        color: const Color(0xFFFFECF4),
      ),
      FeatureItem(
        title: 'Battle',
        subtitle: '1 vs 1 live quiz',
        emoji: '🎮',
        color: const Color(0xFFEFF0FF),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final items = _items();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return FeatureCard(item: item, primaryColor: primaryColor);
      },
    );
  }
}

class FeatureItem {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;

  FeatureItem({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
  });
}

class FeatureCard extends StatelessWidget {
  final FeatureItem item;
  final Color primaryColor;

  const FeatureCard({
    super.key,
    required this.item,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.title} page coming soon'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 3D-style emoji badge
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  item.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
