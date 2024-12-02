import 'package:flutter/material.dart';
import 'package:pathly/views/components/step.dart';
import 'package:pathly/views/components/roadmap.dart';






class FrontendRoadmapScreen extends StatelessWidget {
  static const String id = '/frontend_roadmap_screen';
  final List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'HTML & CSS Basics',
      'description': 'Learn HTML and CSS to structure and style webpages.',
      'progress': 0.5,
      'color': const Color(0xFF9FE870),
      'icon': Icons.code,
      'completed': false,
    },
    {
      'title': 'JavaScript Essentials',
      'description': 'Learn JavaScript to add interactivity.',
      'progress': 0.2,
      'color': const Color(0xFF70E8E8),
      'icon': Icons.javascript,
      'completed': false,
    },
  ];

   FrontendRoadmapScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: RoadmapWidget(
        title: 'Frontend Development Roadmap',
        description: 'Master the basics of frontend development step-by-step.',
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
