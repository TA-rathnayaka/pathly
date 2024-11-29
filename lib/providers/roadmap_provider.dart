import 'package:flutter/material.dart';
import 'package:pathly/services/roadmap_service.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';

class RoadmapProvider extends ChangeNotifier {
  final RoadmapService _roadmapService;

  RoadmapProvider(this._roadmapService);

  List<Roadmap> _roadmaps = [];

  List<Roadmap> get roadmaps => List.unmodifiable(_roadmaps);

  // Fetch all roadmaps from Firebase
  Future<void> fetchRoadmaps() async {
    try {
      _roadmaps = await _roadmapService.getRoadmaps();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch roadmaps: $e');
    }
  }

  // Add a new roadmap
  void addRoadmap(String title, String description, IconData icon) {
    _roadmapService.addRoadmap(title, description, icon);
    notifyListeners();
  }

  // Add a stage to a specific roadmap
  void addStageToRoadmap(String roadmapTitle, RoadmapStage stage) {
    _roadmapService.addStageToRoadmap(roadmapTitle, stage);
    notifyListeners();
  }

  // Remove a stage from a specific roadmap
  void removeStageFromRoadmap(String roadmapTitle, int stageIndex) {
    _roadmapService.removeStageFromRoadmap(roadmapTitle, stageIndex);
    notifyListeners();
  }

  // Update a stage in a specific roadmap
  void updateStageInRoadmap(String roadmapTitle, int stageIndex, RoadmapStage updatedStage) {
    _roadmapService.updateStageInRoadmap(roadmapTitle, stageIndex, updatedStage);
    notifyListeners();
  }
}