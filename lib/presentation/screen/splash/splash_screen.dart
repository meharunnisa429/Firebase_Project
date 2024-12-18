import 'package:firebase_project/presentation/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("FIRE BASE"),
      ),
    );
  }
}
