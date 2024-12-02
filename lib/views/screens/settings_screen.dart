import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:pathly/views/components/settings_group.dart';
import 'package:pathly/views/components/settings_item.dart';
import 'package:pathly/views/components/icon_style.dart';
import 'package:pathly/views/components/simple_user_card.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = '/settings_screen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final isDarkMode = settingsProvider.isDarkMode;

    // Define text color based on theme (shades of black/white)
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;
    final appBarColor = isDarkMode ? Colors.black : Colors.white;
    final scaffoldBgColor = isDarkMode ? AppColors.darkBackground : Colors.white;
    final cardBgColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Settings',
          style: TextStyle(color: textColor), // Ensure title is visible
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // User Profile Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SimpleUserCard(
                  userProfilePic: AssetImage('images/user_profile.png'),
                  userName: 'John Doe',
                  userMoreInfo: Text(
                    'john.doe@example.com',
                    style: TextStyle(fontSize: 16, color: subtitleColor), // Set subtitle color based on theme
                  ),
                  onTap: () {
                    // Add profile picture change functionality here
                    print('Profile tapped');
                  },
                ),
              ),

              // Settings Groups
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SettingsGroup(
                  settingsGroupTitle: 'General',
                  items: [
                    SettingsItem(
                      icons: Icons.language,
                      title: 'Language',
                      subtitle: 'Change the app language',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      onTap: () {
                        print('Language settings tapped');
                        // Handle language change here
                      },
                    ),
                    SettingsItem(
                      icons: Icons.dark_mode,
                      title: 'Dark Mode',
                      subtitle: 'Enable/Disable dark mode',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      trailing: Switch(
                        value: settingsProvider.isDarkMode,
                        onChanged: (bool value) {
                          settingsProvider.toggleDarkMode(value);
                          print('Dark Mode toggled');
                        },
                        activeColor: isDarkMode ? Colors.grey[400] : Colors.black,
                        inactiveThumbColor: Colors.grey[500],
                        inactiveTrackColor: isDarkMode ? Colors.white24 : Colors.black12,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SettingsGroup(
                  settingsGroupTitle: 'Account',
                  items: [
                    SettingsItem(
                      icons: Icons.security,
                      title: 'Privacy',
                      subtitle: 'Manage your privacy settings',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      onTap: () {
                        print('Privacy settings tapped');
                      },
                    ),
                    SettingsItem(
                      icons: Icons.lock,
                      title: 'Change Password',
                      subtitle: 'Update your account password',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      onTap: () {
                        print('Change Password tapped');
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SettingsGroup(
                  settingsGroupTitle: 'Notifications',
                  items: [
                    SettingsItem(
                      icons: Icons.notifications,
                      title: 'Push Notifications',
                      subtitle: 'Enable or disable notifications',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      trailing: Switch(
                        value: settingsProvider.isPushNotificationsEnabled,
                        onChanged: (bool value) {
                          settingsProvider.togglePushNotifications(value);
                          print('Push Notifications toggled');
                        },
                        activeColor: isDarkMode ? Colors.grey[400] : Colors.black,
                        inactiveThumbColor: Colors.grey[500],
                        inactiveTrackColor: isDarkMode ? Colors.white24 : Colors.black12,
                      ),
                    ),
                    SettingsItem(
                      icons: Icons.email,
                      title: 'Email Notifications',
                      subtitle: 'Receive updates via email',
                      iconStyle: IconStyle(
                        backgroundColor: Colors.transparent,
                        iconsColor: textColor,
                      ),
                      trailing: Switch(
                        value: settingsProvider.isEmailNotificationsEnabled,
                        onChanged: (bool value) {
                          settingsProvider.toggleEmailNotifications(value);
                          print('Email Notifications toggled');
                        },
                        activeColor: isDarkMode ? Colors.grey[400] : Colors.black,
                        inactiveThumbColor: Colors.grey[500],
                        inactiveTrackColor: isDarkMode ? Colors.white24 : Colors.black12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}