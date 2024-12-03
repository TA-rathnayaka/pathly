import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathly/config/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/navigator_provider.dart';
import 'package:pathly/providers/settings_provider.dart';
import 'package:pathly/config/app_theme.dart';
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
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Builder(
        builder: (context) {
          final isDarkMode = context.watch<SettingsProvider>().isDarkMode;

          // Define the base theme
          final baseTheme = ThemeData(
            primarySwatch: Colors.blue,
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            colorScheme: ColorScheme(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
              primary: Colors.black54,  // Primary color can be updated as per requirements
              onPrimary: Colors.white,
              secondary: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
              onSecondary: Colors.white,
              surface: isDarkMode ? AppColors.darkCard : AppColors.lightCard,
              onSurface: Colors.white,
              error: Colors.red,
              onError: Colors.white,
            ),
          );
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.fetchUserInfo();
          return MaterialApp(
            title: 'Pathly',
            theme: baseTheme.copyWith(
              scaffoldBackgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
              textTheme: baseTheme.textTheme.copyWith(
                headlineSmall: isDarkMode ? AppTextStyles.headingDark : AppTextStyles.headingLight,
                bodyMedium: isDarkMode ? AppTextStyles.subheadingDark : AppTextStyles.subheadingLight,  // Replaced subtitle1 with bodyText2
                bodyLarge: isDarkMode ? AppTextStyles.searchHintDark : AppTextStyles.searchHintLight,
              ).apply(
                bodyColor: isDarkMode ? Colors.white : Colors.black,
              ),
              // Button Text Theme
              buttonTheme: ButtonThemeData(
                buttonColor: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent, // Button color
              ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: isDarkMode
                        ? AppTextStyles.categoryTitleDark.color
                        : AppTextStyles.categoryTitleLight.color,
                  ),
                ),
              ),

            routes: routes,
          );
        },
      ),
    );
  }
}
