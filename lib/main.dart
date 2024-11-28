import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathly/config/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PathlyApp());
}

class PathlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
