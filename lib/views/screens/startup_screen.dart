import 'package:flutter/material.dart';
import 'package:pathly/views/constants/constants.dart';
import 'package:pathly/views/components/hexagon_button.dart';
import 'package:pathly/views/screens/login_screen.dart';
import 'package:pathly/views/screens/signup_screen.dart';

class StartupScreen extends StatelessWidget {
  static final String id = '/fda';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top logo and design
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.sports_soccer, color: Colors.red, size: 30),
                      SizedBox(width: 8),
                      Text(
                        'PATHLY',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Placeholder for the background star design
                  Image.asset('assets/path_design.png', height: 200),
                ],
              ),
            ),

            // Main content - title and subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'KEEP AN EYE ON YOUR PATH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Watch sports live or highlights, read every news from your smartphone',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HexagonButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    text: "Login".toUpperCase(),
                    buttonColor: kPrimaryColor,
                    textStyle: kPrimaryButtonTextStyle,
                  ),
                  SizedBox(height: 16),
                  HexagonButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    text: "Create Account".toUpperCase(),
                    buttonColor: kSecondaryColor,
                    textStyle: kSecondaryButtonTextStyle,
                  )
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
