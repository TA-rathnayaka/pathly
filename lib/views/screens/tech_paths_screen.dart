// import 'package:flutter/material.dart';
// import 'package:pathly/views/components/tech_path_card.dart';
// import 'frontend_roadmap_page.dart';
// import 'backend_roadmap_screen.dart';
// import 'data_science_roadmap.dart';
// import 'mobile_app_roadmap.dart';
//
// class TechPathScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     // Set background color based on theme
//     final backgroundColor = isDarkMode ? Color(0xFF1A1A1A) : Colors.grey[200];
//
//     return Scaffold(
//       backgroundColor: backgroundColor, // Apply theme-based background color
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // Add padding around the entire ListView
//         child: ListView(
//           children: [
//             TechPathCard(
//               name: 'Frontend Development',
//               description: 'Master UI/UX, HTML, CSS, JavaScript, and modern frameworks',
//               icon: Icons.web,
//               color: Color(0xFF9FE870),
//               progress: 0.0,
//               onTap: () {
//                 Navigator.pushNamed(context, FrontendRoadmapScreen.id);
//               },
//             ),
//             SizedBox(height: 16.0), // Add spacing between cards
//             TechPathCard(
//               name: 'Backend Development',
//               description: 'Learn server-side programming and backend frameworks',
//               icon: Icons.settings_input_component,
//               color: Color(0xFF1E88E5),
//               progress: 0.0,
//               onTap: () {
//                 Navigator.pushNamed(context, BackendRoadmapScreen.id);
//               },
//             ),
//             SizedBox(height: 16.0), // Add spacing between cards
//             TechPathCard(
//               name: 'Data Science',
//               description: 'Learn data analysis, machine learning, and AI',
//               icon: Icons.data_usage,
//               color: Color(0xFF42A5F5),
//               progress: 0.0,
//               onTap: () {
//                 Navigator.pushNamed(context, DataScienceRoadmapScreen.id);
//               },
//             ),
//             SizedBox(height: 16.0), // Add spacing between cards
//             TechPathCard(
//               name: 'Mobile Application',
//               description: 'Master mobile app development with Flutter and Dart',
//               icon: Icons.phone_android,
//               color: Color(0xFF00BFAE),
//               progress: 0.0,
//               onTap: () {
//                 Navigator.pushNamed(context, MobileAppDevelopmentRoadmapScreen.id);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'roadmap_screen.dart'; // Import RoadmapScreen

class TechPathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Set background color based on theme
    final backgroundColor = isDarkMode ? Color(0xFF1A1A1A) : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor, // Apply theme-based background color
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the entire ListView
        child: ListView(
          children: [
            TechPathCard(
              name: 'Frontend Development',
              description: 'Master UI/UX, HTML, CSS, JavaScript, and modern frameworks',
              icon: Icons.web,
              color: Color(0xFF9FE870),
              progress: 0.0,
              onTap: () {
                print('Navigating to Frontend Roadmap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoadmapScreen(roadmapKey: 'frontend'),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0), // Add spacing between cards
            TechPathCard(
              name: 'Backend Development',
              description: 'Learn server-side programming and backend frameworks',
              icon: Icons.settings_input_component,
              color: Color(0xFF1E88E5),
              progress: 0.0,
              onTap: () {
                print('Navigating to Backend Roadmap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoadmapScreen(roadmapKey: 'backend'),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0), // Add spacing between cards
            TechPathCard(
              name: 'Data Science',
              description: 'Learn data analysis, machine learning, and AI',
              icon: Icons.data_usage,
              color: Color(0xFF42A5F5),
              progress: 0.0,
              onTap: () {
                print('Navigating to Data Science Roadmap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoadmapScreen(roadmapKey: 'data_science'),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0), // Add spacing between cards
            TechPathCard(
              name: 'Mobile Application',
              description: 'Master mobile app development with Flutter and Dart',
              icon: Icons.phone_android,
              color: Color(0xFF00BFAE),
              progress: 0.0,
              onTap: () {
                print('Navigating to Mobile Application Roadmap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoadmapScreen(roadmapKey: 'mobile_app'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TechPathCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final double progress;
  final VoidCallback onTap;

  const TechPathCard({
    Key? key,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 32.0, color: color),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
