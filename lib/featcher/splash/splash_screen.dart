import 'package:day2_task/featcher/home/home_screen.dart';
import 'package:day2_task/featcher/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isFirstTime = prefs.getBool('isFirstTime');

      if (isFirstTime == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(child: Lottie.asset('assets/animations/animaed_pan.json')),
    );
  }
}
