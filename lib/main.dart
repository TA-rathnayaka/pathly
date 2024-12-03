import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathly/config/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/navigator_provider.dart';
import 'package:pathly/providers/settings_provider.dart';
import 'package:pathly/config/app_styles.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/services/roadmap_service.dart';
import 'package:pathly/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PathlyApp());
}

class PathlyApp extends StatelessWidget {
  const PathlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoadmapProvider(RoadmapService())),
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()..fetchUserInfo()),
      ],
      child: Builder(
        builder: (context) {
          final isDarkMode = context.watch<SettingsProvider>().isDarkMode;

          // Get the base theme
          final baseTheme = getBaseTheme(isDarkMode);

          // Use the theme function to modify the theme
          return MaterialApp(
            title: 'Pathly',
            theme: getTheme(isDarkMode, baseTheme),
            routes: routes,
          );
        },
      ),
    );
  }
}
