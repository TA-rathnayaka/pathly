import 'package:pathly/models/resource.dart';

class RoadmapStep {
  // Represents a single step in a roadmap
  String stepId;
  String title;
  String description;
  List<Resource> resources;
  int level;
  bool isCompleted;

  // Constructor for RoadmapStep
  RoadmapStep({
    required this.stepId,
    required this.title,
    required this.description,
    required this.resources,
    required this.level,
    this.isCompleted = false, // default value for isCompleted
  });

  // Method to complete the step
  void completeStep() {
    if (!isCompleted) {
      isCompleted = true;
      print('Step "$title" completed!');
    } else {
      print('Step "$title" was already completed.');
    }
  }

  // Method to get details of the step
  Map<String, dynamic> getStepDetails() {
    return {
      'id': stepId,
      'title': title,
      'description': description,
      'level': level,
      'resourcesCount': resources.length,
      'isCompleted': isCompleted,
    };
  }
}
