import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PathProvider extends ChangeNotifier {
  final TextEditingController pathNameController = TextEditingController();
  final List<Map<String, dynamic>> specialPoints = [];
  final ImagePicker picker = ImagePicker();

  void addSpecialPoint(Map<String, dynamic> point) {
    specialPoints.add(point);
    notifyListeners();
  }

  void clear() {
    pathNameController.clear();
    specialPoints.clear();
    notifyListeners();
  }
}