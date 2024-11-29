import 'package:flutter/material.dart';
import 'package:pathly/services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  String? _displayName;
  String? _uid;

  String? get email => _email;
  String? get displayName => _displayName;
  String? get uid => _uid;

  final AuthService _authService = AuthService();

  // Fetch and set the current user info
  Future<void> fetchUserInfo() async {
    final userInfo = await _authService.getUserInfo();
    _email = userInfo['email'];
    _displayName = userInfo['displayName'];
    _uid = userInfo['uid'];
    notifyListeners();
  }

// Optionally, update user info or perform other actions here
}