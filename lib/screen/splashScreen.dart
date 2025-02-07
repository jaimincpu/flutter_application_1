
import 'package:flutter/material.dart';

import '../login/LogChecker.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  super.initState();
  Future.delayed(Duration(seconds: 1), () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogChecker()),
      (route) => false,
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the login page",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
