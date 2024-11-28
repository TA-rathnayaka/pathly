import 'package:flutter/material.dart';

class RoadmapWidget extends StatelessWidget {
  final String title;
  final String description;
  final int totalXP;
  final int currentLevel;
  final List<Widget> steps;

  RoadmapWidget({
    required this.title,
    required this.description,
    required this.totalXP,
    required this.currentLevel,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Level: $currentLevel',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'XP: $totalXP',
                    style: TextStyle(color: Colors.amber, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...steps,
      ],
    );
  }
}
