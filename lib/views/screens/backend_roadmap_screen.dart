import 'package:flutter/material.dart';
import 'package:pathly/views/components/step.dart';
import 'package:pathly/views/components/roadmap.dart';





class BackendRoadmapScreen extends StatelessWidget {
  static const String id = '/backend_roadmap_screen';

  final List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'Node.js Basics',
      'description': 'Learn the basics of Node.js to build server-side applications.',
      'progress': 0.3,
      'color': const Color(0xFF1E88E5),
      'icon': Icons.code,
      'completed': false,
    },
    {
      'title': 'Express Framework',
      'description': 'Learn to use Express.js to create APIs and handle requests.',
      'progress': 0.4,
      'color': const Color(0xFF039BE5),
      'icon': Icons.settings_input_component,
      'completed': false,
    },
    // Add more backend stages as needed
  ];

  BackendRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: RoadmapWidget(
        title: 'Backend Development Roadmap',
        description: 'Learn server-side programming and backend frameworks.',
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
