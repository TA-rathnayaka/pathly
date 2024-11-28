import 'package:flutter/material.dart';
import 'package:pathly/providers/settings_provider.dart'; // Import your SettingsProvider
import 'package:provider/provider.dart'; // Import provider package
import 'package:pathly/views/components/settings_group.dart';
import 'package:pathly/views/components/settings_item.dart';
import 'package:pathly/views/components/icon_style.dart';
import 'package:pathly/views/components/simple_user_card.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = '/settings_screen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SimpleUserCard(
                userProfilePic: AssetImage('assets/user_profile.jpg'),
                userName: 'John Doe',
                userMoreInfo: Text(
                  'john.doe@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                onTap: () {
                  // Add profile picture change functionality here
                  print('Profile tapped');
                },
              ),
            ),

            // Settings Groups
            SettingsGroup(
              settingsGroupTitle: 'General',
              items: [
                SettingsItem(
                  icons: Icons.language,
                  title: 'Language',
                  subtitle: 'Change the app language',
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                    iconsColor: Colors.white,
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
                    backgroundColor: Colors.blue,
                    iconsColor: Colors.white,
                  ),
                  trailing: Switch(
                    value: settingsProvider.isDarkMode,
                    onChanged: (bool value) {
                      settingsProvider.toggleDarkMode(value);
                      print('Dark Mode toggled');
                    },
                  ),
                ),
              ],
            ),

            SettingsGroup(
              settingsGroupTitle: 'Account',
              items: [
                SettingsItem(
                  icons: Icons.security,
                  title: 'Privacy',
                  subtitle: 'Manage your privacy settings',
                  iconStyle: IconStyle(
                    backgroundColor: Colors.orange,
                    iconsColor: Colors.white,
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
                    backgroundColor: Colors.red,
                    iconsColor: Colors.white,
                  ),
                  onTap: () {
                    print('Change Password tapped');
                  },
                ),
              ],
            ),

            SettingsGroup(
              settingsGroupTitle: 'Notifications',
              items: [
                SettingsItem(
                  icons: Icons.notifications,
                  title: 'Push Notifications',
                  subtitle: 'Enable or disable notifications',
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                    iconsColor: Colors.white,
                  ),
                  trailing: Switch(
                    value: settingsProvider.isPushNotificationsEnabled,
                    onChanged: (bool value) {
                      settingsProvider.togglePushNotifications(value);
                      print('Push Notifications toggled');
                    },
                  ),
                ),
                SettingsItem(
                  icons: Icons.email,
                  title: 'Email Notifications',
                  subtitle: 'Receive updates via email',
                  iconStyle: IconStyle(
                    backgroundColor: Colors.cyan,
                    iconsColor: Colors.white,
                  ),
                  trailing: Switch(
                    value: settingsProvider.isEmailNotificationsEnabled,
                    onChanged: (bool value) {
                      settingsProvider.toggleEmailNotifications(value);
                      print('Email Notifications toggled');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}