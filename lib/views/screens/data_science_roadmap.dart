import 'package:flutter/material.dart';
import 'package:pathly/views/components/step.dart';
import 'package:pathly/views/components/roadmap.dart';


class DataScienceRoadmapScreen extends StatelessWidget {
  static const String id = '/data_science_roadmap_screen';

  final List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'Python Basics',
      'description': 'Learn the fundamentals of Python programming.',
      'progress': 0.4,
      'color': Color(0xFF42A5F5),
      'icon': Icons.code,
      'completed': false,
    },
    {
      'title': 'Data Analysis with Pandas',
      'description': 'Learn how to analyze data using the Pandas library.',
      'progress': 0.5,
      'color': Color(0xFF3949AB),
      'icon': Icons.data_usage,
      'completed': false,
    },
    // Add more data science stages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: RoadmapWidget(
        title: 'Data Science Roadmap',
        description: 'Learn data analysis, machine learning, and AI.',
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
