import 'dart:core';

class RoadmapStep {
  String stepId;
  String title;
  String description;
  bool isCompleted;

  RoadmapStep(this.stepId, this.title, this.description, this.isCompleted);

  void completeStep() {
    if (!isCompleted) {
      isCompleted = true;
      print('Step "$title" completed!');
    } else {
      print('Step "$title" was already completed.');
    }
  }
}

class RoadmapProgress {
  String progressId;
  String userId;
  String roadmapId;
  List<RoadmapStep> completedSteps;
  DateTime startDate;
  DateTime lastUpdateDate;

  RoadmapProgress(this.progressId, this.userId, this.roadmapId,
      this.completedSteps, this.startDate, this.lastUpdateDate);

  void updateProgress(RoadmapStep completedStep) {
    if (!completedSteps.contains(completedStep)) {
      completedStep.completeStep();
      completedSteps.add(completedStep);
      lastUpdateDate = DateTime.now();
      print('Progress updated for user $userId on roadmap $roadmapId');
    }
  }

  Map<String, dynamic> getProgress() {
    return {
      'userId': userId,
      'roadmapId': roadmapId,
      'completedSteps': completedSteps.length,
      'startDate': startDate.toIso8601String(),
      'lastUpdateDate': lastUpdateDate.toIso8601String(),
    };
  }
}
