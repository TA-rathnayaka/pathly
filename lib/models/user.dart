import 'dart:core';

class User {
  String userId;
  String username;
  String email;
  String password;
  Map<String, int> expertiseLevels;

  User(this.userId, this.username, this.email, this.password,
      this.expertiseLevels);

  void signUp() {
    // Logic for sign-up
    print('Creating new user: $username');
    print('User $userId signed up successfully');
  }

  void login() {
    // Logic for login
    print('Attempting login for user: $username');
    print('User $userId logged in successfully');
  }

  void updateProfile(
      {String? newUsername,
      String? newEmail,
      Map<String, int>? newExpertiseLevels}) {
    if (newUsername != null) username = newUsername;
    if (newEmail != null) email = newEmail;
    if (newExpertiseLevels != null) expertiseLevels = newExpertiseLevels;
    print('Profile updated for user $userId');
  }
}
