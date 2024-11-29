import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap_stage.dart';


class Roadmap {
  String title;
  String description; // Added description field
  IconData icon; // Added icon field
  List<RoadmapStage> stages;

  Roadmap({
    required this.title,
    required this.description,
    required this.icon,
    List<RoadmapStage>? stages,
  }) : stages = stages ?? []; // If no stages are provided, initialize with an empty list
}
