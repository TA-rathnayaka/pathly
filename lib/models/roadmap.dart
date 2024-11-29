import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap_stage.dart';

class Roadmap {
  String id; // Added id field
  String title;
  String description; // Added description field
  IconData icon; // Added icon field
  List<RoadmapStage> stages;

  // Constructor with all required fields including the id
  Roadmap({
    required this.id, // id is now a required field
    required this.title,
    required this.description,
    required this.icon,
    List<RoadmapStage>? stages, // Optional parameter for stages
  }) : stages = stages ?? []; // If no stages are provided, initialize with an empty list
}