import 'package:flutter/material.dart';
import 'package:pathly/components/hexagon_button.dart';
import 'package:pathly/constants/constants.dart';

class SignUpScreen extends StatelessWidget {
  static final String id = '/sign_up_screen';
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
                  'Create your PATHLY id',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Get news, game updates, highlights, and more info on your favorite teams',
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
                      decoration: kTextFieldDecoration.copyWith(hintText: "First Name"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(hintText: "Second Name"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    // Checkbox and Terms
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        Text('I agree to the '),
                        Text(
                          'Terms',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                        Text(' and '),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    HexagonButton(onPressed: (){}, text: "Sign Up", buttonColor: kTerTertiary, textStyle: kTertiaryButtonTextStyle,),
                    SizedBox(height: 20),
                    Text(
                      'By agreeing to the above terms, you are consenting that your personal information will be collected, stored, and processed...',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
