import 'package:flutter/material.dart';

class RoadmapCategory {
  final String title;
  final String description;
  final List<String> subtopics;
  final Color color;
  final IconData icon;

  RoadmapCategory({
    required this.title,
    required this.description,
    required this.subtopics,
    required this.color,
    required this.icon,
  });
}
