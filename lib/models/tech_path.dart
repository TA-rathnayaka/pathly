// tech_path_model.dart
import 'package:flutter/material.dart';

class TechPath {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final double progress;
  final String route;

  TechPath({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.route,
  });

  // Factory method to parse from JSON
  factory TechPath.fromJson(Map<String, dynamic> json) {
    return TechPath(
      name: json['name'],
      description: json['description'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
      progress: json['progress'],
      route: json['route'],
    );
  }

  // Convert to JSON for potential API or database use
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon': icon.codePoint,
      'color': color.value,
      'progress': progress,
      'route': route,
    };
  }
}
