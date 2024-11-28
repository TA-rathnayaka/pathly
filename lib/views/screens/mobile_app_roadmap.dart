
import 'package:flutter/material.dart';
import 'package:pathly/views/components/step.dart';
import 'package:pathly/views/components/roadmap.dart';

class MobileAppRoadmapScreen extends StatelessWidget {
  static const String id = '/mobile_app_roadmap_screen';

  final List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'Flutter Basics',
      'description': 'Learn the fundamentals of Flutter and Dart.',
      'progress': 0.3,
      'color': Color(0xFF00BFAE),
      'icon': Icons.flutter_dash,
      'completed': false,
    },
    {
      'title': 'Building UIs in Flutter',
      'description': 'Learn how to design beautiful UIs with Flutter.',
      'progress': 0.4,
      'color': Color(0xFF0288D1),
      'icon': Icons.phone_android,
      'completed': false,
    },
    // Add more mobile app stages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: RoadmapWidget(
        title: 'Mobile App Development Roadmap',
        description: 'Master mobile app development with Flutter and Dart.',
        totalXP: 0,
        currentLevel: 1,
        steps: roadmapStages.map((stage) {
          return StepWidget(
            title: stage['title'],
            description: stage['description'],
            icon: stage['icon'],
            color: stage['color'],
            progress: stage['progress'],
            onTap: () {
              // Handle stage click event
              print('${stage['title']} clicked');
            },
          );
        }).toList(),
      ),
    );
  }
}
