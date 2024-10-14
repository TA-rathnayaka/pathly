import 'package:flutter/material.dart';
import 'package:pathly/screens/login_screen.dart';
import 'package:pathly/screens/signup_screen.dart';
import 'package:pathly/screens/startup_screen.dart';

void main() {
  runApp(PathlyApp());
}

class PathlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        StartupScreen.id: (context) => StartupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      },
    );
  }
}
