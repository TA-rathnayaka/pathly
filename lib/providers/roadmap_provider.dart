import 'package:flutter/material.dart';

class RoadmapStage {
  final String title;
  final String description;
  final DateTime? dueDate;

  RoadmapStage({required this.title, required this.description, this.dueDate});
}

class Roadmap {
  String title; // No need to keep _title private
  List<RoadmapStage> stages; // No need to keep _stages private

  Roadmap({required this.title, List<RoadmapStage>? stages})
      : stages = stages ?? []; // If no stages are provided, initialize with an empty list

// No need for setters as the list can be modified directly
}

class RoadmapProvider extends ChangeNotifier {
  final List<Roadmap> _roadmaps = [];

  // Getter that returns an unmodifiable list of roadmaps
  List<Roadmap> get roadmaps => List.unmodifiable(_roadmaps);

  // Method to add a new roadmap
  void addRoadmap(String title) {
    _roadmaps.add(Roadmap(title: title)); // Modify the mutable _roadmaps list
    notifyListeners(); // Notify listeners of the change
  }

  // Method to add a stage to a specific roadmap
  void addStageToRoadmap(String roadmapTitle, RoadmapStage stage) {
    final roadmap = _roadmaps.firstWhere(
      (r) => r.title == roadmapTitle,
      orElse: () => throw Exception('Roadmap not found'),
    );
    roadmap.stages.add(stage);
    notifyListeners(); // Notify listeners of the change
  }

  // Method to remove a stage from a specific roadmap
  void removeStageFromRoadmap(String roadmapTitle, int stageIndex) {
    final roadmap = _roadmaps.firstWhere(
      (r) => r.title == roadmapTitle,
      orElse: () => throw Exception('Roadmap not found'),
    );
    roadmap.stages.removeAt(
        stageIndex); // Modify the mutable stages list inside the roadmap
    notifyListeners(); // Notify listeners of the change
  }
}
