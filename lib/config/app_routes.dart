import 'package:flutter/material.dart';
import 'package:pathly/views/screens/_all.dart';
import 'package:pathly/views/screens/dashboard.dart';
import 'package:pathly/views/screens/main_screen.dart';
import 'package:provider/provider.dart';

final routes = {
  SplashScreen.id: (context) => SplashScreen(),
  Dashboard.id: (context) => Dashboard(),
  LoginScreen.id: (context) => LoginScreen(),
  SignUpScreen.id: (context) => SignUpScreen(),
  MainScreen.id: (context) => MainScreen(),
  FrontendRoadmapScreen.id: (context) => FrontendRoadmapScreen(),
  SettingsScreen.id: (context) => SettingsScreen(),
  CreatePathScreen.id: (context)=> CreatePathScreen()
};
