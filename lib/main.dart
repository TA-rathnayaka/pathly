import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathly/config/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/navigator_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PathlyApp());
}

class PathlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Pathly',
        theme: ThemeData.dark(), // Customize as needed

        routes: routes
      ),
    );
  }
}
