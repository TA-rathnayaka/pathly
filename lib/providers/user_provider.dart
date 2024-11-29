import 'package:flutter/material.dart';
import 'package:pathly/services/auth_service.dart';
import 'package:pathly/services/roadmap_service.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  String? _displayName;
  String? _uid;
  List<String> _enrolledRoadmapIds = []; // Store enrolled roadmap IDs

  String? get email => _email;
  String? get displayName => _displayName;
  String? get uid => _uid;
  List<String> get enrolledRoadmapIds => _enrolledRoadmapIds;

  final AuthService _authService = AuthService();
  final RoadmapService _roadmapService = RoadmapService();

  // Fetch and set the current user info
  Future<void> fetchUserInfo() async {
    try {
      final userInfo = await _authService.getUserInfo();
      _email = userInfo['email'];
      _displayName = userInfo['displayName'];
      _uid = userInfo['uid'];

      // Fetch enrolled roadmap IDs after user info is loaded
      if (_uid != null) {
        await fetchEnrolledRoadmapIds();
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user info: $e');
    }
  }

  // Fetch enrolled roadmap IDs for the current user
  Future<void> fetchEnrolledRoadmapIds() async {
    try {
      if (_uid != null) {
        _enrolledRoadmapIds = await _roadmapService.getEnrolledRoadmapIdsForUser(_uid!);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch enrolled roadmap IDs: $e');
    }
  }

  // Enroll in a roadmap by adding its ID
  Future<void> enrollInRoadmap(String roadmapId) async {
    try {
      if (_uid != null) {
        await _roadmapService.enrollUserInRoadmap(_uid!, roadmapId);
        _enrolledRoadmapIds.add(roadmapId);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to enroll in roadmap: $e');
    }
  }

  // Remove an enrolled roadmap by its ID
  Future<void> removeEnrolledRoadmap(String roadmapId) async {
    try {
      if (_uid != null) {
        await _roadmapService.removeUserFromRoadmap(_uid!, roadmapId);
        _enrolledRoadmapIds.remove(roadmapId);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to remove enrolled roadmap: $e');
    }
  }
}