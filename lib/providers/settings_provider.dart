import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isPushNotificationsEnabled = false;
  bool _isEmailNotificationsEnabled = true;
  String _language = 'en'; // Default language is English

  bool get isDarkMode => _isDarkMode;
  bool get isPushNotificationsEnabled => _isPushNotificationsEnabled;
  bool get isEmailNotificationsEnabled => _isEmailNotificationsEnabled;
  String get language => _language;

  // Toggle dark mode
  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  // Toggle push notifications
  void togglePushNotifications(bool value) {
    _isPushNotificationsEnabled = value;
    notifyListeners();
  }

  // Toggle email notifications
  void toggleEmailNotifications(bool value) {
    _isEmailNotificationsEnabled = value;
    notifyListeners();
  }

  // Change the app language
  void changeLanguage(String language) {
    _language = language;
    notifyListeners();
  }
}