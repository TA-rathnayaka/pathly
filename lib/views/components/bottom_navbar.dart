import 'package:pathly/views/constants/bottom_navbar_constants.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavbar({super.key, 
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark; // Detect dark mode

    // Define colors based on the current theme
    Color backgroundColor = isDarkMode ? Colors.black : kBackgroundColorBottomNavbar;
    Color selectedItemColor = isDarkMode ? Colors.white : kSelectedItemColorBottomNavbar;
    Color unselectedItemColor = isDarkMode ? Colors.grey.withOpacity(0.6) : Colors.grey.withOpacity(0.6);

    return Container(
      color: backgroundColor, // Set background color for the navbar
      child: BottomNavigationBar(
        showSelectedLabels: true, // Show selected labels
        showUnselectedLabels: true, // Show unselected labels
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor, // Match navbar background color
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? selectedItemColor : unselectedItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person, // Appropriate icon for Following
              color: currentIndex == 1 ? selectedItemColor : unselectedItemColor,
            ),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline, // Appropriate icon for Create Path
              color: currentIndex == 2 ? selectedItemColor : unselectedItemColor,
            ),
            label: 'Create Path',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings, // Appropriate icon for Settings
              color: currentIndex == 3 ? selectedItemColor : unselectedItemColor,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}