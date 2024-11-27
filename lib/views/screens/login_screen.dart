import 'package:flutter/material.dart';
import 'package:pathly/views/constants/constants.dart';
import 'package:pathly/views/components/hexagon_button.dart';


class LoginScreen extends StatelessWidget {
  static const String id = '/login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400], // Background color for header
      body: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.sports_basketball, color: Colors.white, size: 40), // Logo/Icon
                SizedBox(height: 10),
                Text(
                  'Log in to your PATHLY id',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Access your news, game updates, and favorite teams',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Form section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    HexagonButton(onPressed: (){}, text: "Login", buttonColor: kTerTertiary, textStyle: kTertiaryButtonTextStyle,),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account? '),
                        TextButton(
                          onPressed: () {
                            // Navigate to Sign-up Screen
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
