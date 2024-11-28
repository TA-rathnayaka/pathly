import 'package:flutter/material.dart';
import 'package:pathly/views/screens/_all.dart';
import 'package:pathly/views/components/bottom_navbar.dart';
import 'package:pathly/views/screens/dashboard.dart';
import 'package:pathly/views/screens/tech_paths_screen.dart';
import 'package:pathly/providers/navigator_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static String id = '/main-screen';

  final List<Widget> _pages = [
    Dashboard(),
    TechPathsScreen(),
    Dashboard(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return Scaffold(
          body: (navigatorProvider.currentIndex >= 0 &&
              navigatorProvider.currentIndex < _pages.length)
              ? _pages[navigatorProvider.currentIndex]
              : Dashboard(),
          bottomNavigationBar: BottomNavbar(
            currentIndex: navigatorProvider.currentIndex,
            onTap: (int index) {
              navigatorProvider.setCurrentIndex(index);
            },
          ),
        );
      },
    );
  }
}