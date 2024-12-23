import 'package:flutter/material.dart';
import 'package:pathly/views/screens/_all.dart';
import 'package:pathly/views/components/bottom_navbar.dart';
import 'package:pathly/providers/navigator_provider.dart';
import 'package:pathly/providers/create_screen_provider.dart';
import 'package:provider/provider.dart';




class MainScreen extends StatelessWidget {
  static String id = '/main-screen';

  // Wrapping pages with individual ChangeNotifierProvider if needed
  final List<Widget> _pages = [
    const Dashboard(),
    const TechPathScreen(),
    ChangeNotifierProvider(
      create: (_) => CreateScreenState(), // Add state specific to CreatePathScreen
      child: CreatePathScreen(),
    ),
    const SettingsScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return Scaffold(
          body: (navigatorProvider.currentIndex >= 0 &&
              navigatorProvider.currentIndex < _pages.length)
              ? _pages[navigatorProvider.currentIndex]
              : const Dashboard(),
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




