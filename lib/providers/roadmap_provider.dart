import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';


class RoadmapProvider extends ChangeNotifier {
  final List<Roadmap> _roadmaps = [];

  // Getter that returns an unmodifiable list of roadmaps
  List<Roadmap> get roadmaps => List.unmodifiable(_roadmaps);

  // Method to add a new roadmap with description and icon
  void addRoadmap(String title, String description, IconData icon) {
    _roadmaps.add(Roadmap(
      title: title,
      description: description,
      icon: icon,
    ));
    notifyListeners(); // Notify listeners of the change
  }

  // Method to add a stage to a specific roadmap
  void addStageToRoadmap(String roadmapTitle, RoadmapStage stage) {
    try {
      final roadmap = _roadmaps.firstWhere(
            (r) => r.title == roadmapTitle,
      );
      roadmap.stages.add(stage);
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      throw Exception('Roadmap not found');
    }
  }

  // Method to remove a stage from a specific roadmap
  void removeStageFromRoadmap(String roadmapTitle, int stageIndex) {
    try {
      final roadmap = _roadmaps.firstWhere(
            (r) => r.title == roadmapTitle,
      );
      roadmap.stages.removeAt(stageIndex); // Modify the mutable stages list inside the roadmap
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      throw Exception('Roadmap not found');
    }
  }
  void updateStageInRoadmap(String roadmapTitle, int stageIndex, RoadmapStage updatedStage) {
    try {
      final roadmap = _roadmaps.firstWhere((r) => r.title == roadmapTitle);
      roadmap.stages[stageIndex] = updatedStage;
      notifyListeners();
    } catch (e) {
      throw Exception('Roadmap not found');
    }
  }
}