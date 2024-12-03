import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap_stage.dart';

class Roadmap {
  String id; // Unique identifier for the roadmap
  String title; // Title of the roadmap
  String description; // Description of the roadmap
  IconData icon; // Icon associated with the roadmap
  List<RoadmapStage> stages; // Stages associated with the roadmap
  String imageUrl; // URL of the image associated with the roadmap
  String uid; // Unique identifier for the user who created the roadmap

  // Constructor with all required fields including the imageUrl and uid
  Roadmap({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    List<RoadmapStage>? stages, // Optional parameter for stages
    required this.imageUrl, // Required parameter for imageUrl
    required this.uid, // Required parameter for uid of the creator
  }) : stages = stages ?? []; // If no stages are provided, initialize with an empty list
}