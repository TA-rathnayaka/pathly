import 'package:pathly/models/sub_task.dart';

class RoadmapStage {
  final String title; // Title of the stage
  final String description; // Description of the stage
  final List<Subtask> subtasks; // List of subtasks associated with this stage

  RoadmapStage({
    required this.title,
    required this.description,
    this.subtasks = const [], // Default to an empty list if no subtasks are provided
  });
}