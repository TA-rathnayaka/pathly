import 'package:flutter/material.dart';
import 'package:pathly/views/screens/dashboard.dart';
import 'package:pathly/views/screens/login_screen.dart';
import 'package:pathly/services/auth_service.dart';
import 'package:pathly/views/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  static final String id = '/';

  Future<void> _navigateToLoginOrDashboard(BuildContext context) async {
    bool isAuthenticated = await AuthService().isUserAuthenticated();
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          _navigateToLoginOrDashboard(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 32),
          child: Container(
            child: Text(
              "Get Started",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splash.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Learn from the Best",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 0.9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Pathly",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  letterSpacing: 1.9,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}