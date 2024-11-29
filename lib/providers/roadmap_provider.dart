import 'package:flutter/material.dart';
import 'package:pathly/services/roadmap_service.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';

class RoadmapProvider extends ChangeNotifier {
  final RoadmapService _roadmapService;

  RoadmapProvider(this._roadmapService) {
    fetchRoadmaps();
  }

  List<Roadmap> _roadmaps = [];

  List<Roadmap> get roadmaps => List.unmodifiable(_roadmaps);

  // Fetch all roadmaps from Firebase and keep a local copy
  Future<void> fetchRoadmaps() async {
    try {
      final fetchedRoadmaps = await _roadmapService.getRoadmaps();
      _roadmaps = fetchedRoadmaps;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch roadmaps: $e');
    }
  }

  // Add a new roadmap both locally and on the server
  Future<void> addRoadmap(String title, String description, IconData icon) async {
    try {
      final newRoadmap = Roadmap(
        title: title,
        description: description,
        icon: icon,
        stages: [],  // Initialize with no stages
      );

      // Add to the local list
      _roadmaps.add(newRoadmap);

      // Also update the backend (Firebase or any service you're using)
      await _roadmapService.addRoadmap(title, description, icon);

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add roadmap: $e');
    }
  }

  // Add a stage to a specific roadmap, both locally and in the backend
  void addStageToRoadmap(String roadmapTitle, RoadmapStage stage) async {
    try {
      final roadmapIndex = _roadmaps.indexWhere((r) => r.title == roadmapTitle);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex].stages.add(stage);
        await _roadmapService.addStageToRoadmap(roadmapTitle, stage);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to add stage: $e');
    }
  }

  // Remove a stage from a specific roadmap, both locally and in the backend
  void removeStageFromRoadmap(String roadmapTitle, int stageIndex) async {
    try {
      final roadmapIndex = _roadmaps.indexWhere((r) => r.title == roadmapTitle);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex].stages.removeAt(stageIndex);
        await _roadmapService.removeStageFromRoadmap(roadmapTitle, stageIndex);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to remove stage: $e');
    }
  }

  // Update a stage in a specific roadmap, both locally and in the backend
  void updateStageInRoadmap(String roadmapTitle, int stageIndex, RoadmapStage updatedStage) async {
    try {
      final roadmapIndex = _roadmaps.indexWhere((r) => r.title == roadmapTitle);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex].stages[stageIndex] = updatedStage;
        await _roadmapService.updateStageInRoadmap(roadmapTitle, stageIndex, updatedStage);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update stage: $e');
    }
  }
}