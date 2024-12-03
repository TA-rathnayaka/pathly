import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pathly/services/auth_service.dart';
import 'package:pathly/views/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      User? user = await _authService.signInEmailAndPassword(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, Dashboard.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials, please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF2A2A2A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.alt_route_rounded, size: 80, color: Color(0xFF9FE870)),
                      SizedBox(height: 24),
                      Text(
                        'Eureka.',
                        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Discover personalized roadmaps to guide your tech journey  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Color(0xFFCCCCCC)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
                              filled: true,
                              fillColor: const Color(0xFF3A3A3A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF9FE870)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
                              filled: true,
                              fillColor: const Color(0xFF3A3A3A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9FE870)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9FE870),
                              foregroundColor: const Color(0xFF1A1A1A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Get Started",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('New to Pathly? ', style: TextStyle(color: Color(0xFFCCCCCC))),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup_screen');
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(color: Color(0xFF9FE870), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}