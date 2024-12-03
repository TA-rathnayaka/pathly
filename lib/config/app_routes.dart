import 'package:pathly/views/screens/_all.dart';
import 'package:pathly/views/screens/main_screen.dart';

final routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  Dashboard.id: (context) => const Dashboard(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignUpScreen.id: (context) => const SignUpScreen(),
  MainScreen.id: (context) =>  MainScreen(),
  SettingsScreen.id: (context) => const SettingsScreen(),
  CreatePathScreen.id: (context)=> CreatePathScreen()
};
