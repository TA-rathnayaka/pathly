
import 'package:flutter/material.dart';
import 'package:pathly/views/components/tech_path_card.dart';
import 'frontend_roadmap_page.dart';
import 'backend_roadmap_screen.dart';
import 'data_science_roadmap.dart';
import 'mobile_app_roadmap.dart';

class TechPathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: ListView(
        children: [
          TechPathCard(
            name: 'Frontend Development',
            description: 'Master UI/UX, HTML, CSS, JavaScript, and modern frameworks',
            icon: Icons.web,
            color: Color(0xFF9FE870),
            progress: 0.0,
            onTap: () {
              Navigator.pushNamed(context, FrontendRoadmapScreen.id);
            },
          ),
          TechPathCard(
            name: 'Backend Development',
            description: 'Learn server-side programming and backend frameworks',
            icon: Icons.settings_input_component,
            color: Color(0xFF1E88E5),
            progress: 0.0,
            onTap: () {
              Navigator.pushNamed(context, BackendRoadmapScreen.id);
            },
          ),
          TechPathCard(
            name: 'Data Science',
            description: 'Learn data analysis, machine learning, and AI',
            icon: Icons.data_usage,
            color: Color(0xFF42A5F5),
            progress: 0.0,
            onTap: () {
              Navigator.pushNamed(context, DataScienceRoadmapScreen.id);
            },
          ),
          TechPathCard(
            name: 'Mobile Application',
            description: 'Master mobile app development with Flutter and Dart',
            icon: Icons.phone_android,
            color: Color(0xFF00BFAE),
            progress: 0.0,
            onTap: () {
              Navigator.pushNamed(context, MobileAppRoadmapScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
