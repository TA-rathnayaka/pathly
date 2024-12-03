import 'package:flutter/material.dart';

class CreateScreenState extends ChangeNotifier {
  String _title = '';
  String _description = '';
  IconData _selectedIcon = Icons.star; // Default icon
  String _imageUrl = ''; // Add a private field for imageUrl

  // Getters
  String get title => _title;
  String get description => _description;
  IconData get selectedIcon => _selectedIcon;
  String get imageUrl => _imageUrl; // Getter for imageUrl

  // Setters
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setSelectedIcon(IconData icon) {
    _selectedIcon = icon;
    notifyListeners();
  }

  void setImageUrl(String url) { // Setter for imageUrl
    _imageUrl = url;
    notifyListeners();
  }

  // Method to reset form data
  void resetForm() {
    _title = '';
    _description = '';
    _selectedIcon = Icons.star; // Reset to default
    _imageUrl = ''; // Reset imageUrl to an empty string
    notifyListeners();
  }
}