import 'package:flutter/material.dart';
import 'package:garage_app/presentation/screens/login_screen.dart';
import 'package:garage_app/presentation/screens/user_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ?  HomeScreen() :  LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.webp'),
      ),
    );
  }
}
