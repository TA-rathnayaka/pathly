import 'dart:core';

class RoadmapStep {
  String stepId;
  String title;
  String description;
  bool isCompleted;

  RoadmapStep(this.stepId, this.title, this.description, this.isCompleted);

  void completeStep() {
    isCompleted = true;
  }

  Map<String, dynamic> getStepDetails() {
    return {
      'id': stepId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}

class Roadmap {
  String roadmapId;
  String title;
  String description;
  String level;
  String category;
  List<RoadmapStep> steps;

  Roadmap(this.roadmapId, this.title, this.description, this.level,
      this.category, this.steps);

  Map<String, dynamic> getRoadmapDetails() {
    return {
      'id': roadmapId,
      'title': title,
      'description': description,
      'level': level,
      'category': category,
      'stepsCount': steps.length,
    };
  }

  void markStepCompleted(String stepId) {
    for (var step in steps) {
      if (step.stepId == stepId && !step.isCompleted) {
        step.completeStep();
        break;
      }
    }
  }
}
