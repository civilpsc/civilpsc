import 'package:flutter/material.dart';
import 'screens/otp_screen.dart';
import 'screens/home_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        scaffoldBackgroundColor: const Color(0xFFF5F6FF),
        fontFamily: 'Roboto',
      ),
      home: const AuthGate(),
    );
  }
}

// ---------------- AUTH GATE ----------------

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _otpSent = false;
  bool _loggedIn = false;
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    if (!_otpSent) {
      return PhoneLoginScreen(
        onOtpSent: (phone) {
          setState(() {
            _otpSent = true;
            _phone = phone;
          });
        },
      );
    }

    if (!_loggedIn) {
      return OtpVerifyScreen(
        phone: _phone,
        onVerified: () {
          setState(() {
            _loggedIn = true;
          });
        },
      );
    }

    return const HomeScreen();
  }
}
