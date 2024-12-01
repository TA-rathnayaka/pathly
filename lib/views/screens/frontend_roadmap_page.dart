// import 'dart:math';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:pathly/views/components/step.dart';
// import 'package:pathly/views/components/roadmap.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
//
//
//
//
//
// class FrontendRoadmapScreen extends StatelessWidget {
//   static const String id = '/frontend_roadmap_screen';
//   final List<Map<String, dynamic>> roadmapStages = [
//     {
//       'title': 'HTML & CSS Basics',
//       'description': 'Learn HTML and CSS to structure and style webpages.',
//       'progress': 0.5,
//       'color': Color(0xFF9FE870),
//       'icon': Icons.code,
//       'completed': false,
//     },
//     {
//       'title': 'JavaScript Essentials',
//       'description': 'Learn JavaScript to add interactivity.',
//       'progress': 0.2,
//       'color': Color(0xFF70E8E8),
//       'icon': Icons.javascript,
//       'completed': false,
//     },
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1A1A1A),
//       body: RoadmapWidget(
//         title: 'Frontend Development Roadmap',
//         description: 'Master the basics of frontend development step-by-step.',
//         totalXP: 0,
//         currentLevel: 1,
//         steps: roadmapStages.map((stage) {
//           return StepWidget(
//             title: stage['title'],
//             description: stage['description'],
//             icon: stage['icon'],
//             color: stage['color'],
//             progress: stage['progress'],
//             onTap: () {
//               // Handle stage click event
//               print('${stage['title']} clicked');
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FrontendRoadmapScreen extends StatefulWidget {
  static const String id = '/frontend_roadmap_screen';

  @override
  _FrontendRoadmapScreenState createState() => _FrontendRoadmapScreenState();
}

class _FrontendRoadmapScreenState extends State<FrontendRoadmapScreen> {
  final List<RoadmapCategory> roadmapCategories = [
    RoadmapCategory(
      title: 'Internet Fundamentals',
      description: 'Understand how the internet works',
      subtopics: [
        'How does the internet work?',
        'HTTP Protocol',
        'Domain Names',
        'Web Hosting',
        'DNS',
        'Browser Mechanics',
      ],
      color: Color(0xFF4A90E2),
      icon: Icons.public,
    ),
    RoadmapCategory(
      title: 'HTML Mastery',
      description: 'Build semantic and accessible web structures',
      subtopics: [
        'HTML Basics',
        'Semantic HTML',
        'Forms & Validation',
        'Web Accessibility',
        'SEO Fundamentals',
      ],
      color: Color(0xFFFF6B6B),
      icon: Icons.code,
    ),
    RoadmapCategory(
      title: 'CSS Expertise',
      description: 'Create responsive and beautiful designs',
      subtopics: [
        'CSS Fundamentals',
        'Layout Techniques',
        'Responsive Design',
        'CSS Preprocessors',
        'CSS Frameworks',
      ],
      color: Color(0xFF4ECDC4),
      icon: Icons.style,
    ),
    RoadmapCategory(
      title: 'JavaScript Deep Dive',
      description: 'Add interactivity and dynamic behavior',
      subtopics: [
        'JavaScript Basics',
        'DOM Manipulation',
        'Fetch API & AJAX',
        'Async Programming',
        'ES6+ Features',
      ],
      color: Color(0xFFFFA726),
      icon: Icons.javascript,
    ),
    RoadmapCategory(
      title: 'Version Control & Package Management',
      description: 'Manage code and dependencies',
      subtopics: [
        'Git Basics',
        'GitHub/GitLab',
        'npm/yarn/pnpm',
        'Collaborative Workflows',
      ],
      color: Color(0xFF7E57C2),
      icon: Icons.merge_type,
    ),
    RoadmapCategory(
      title: 'Modern Frameworks',
      description: 'Choose and master a frontend framework',
      subtopics: [
        'React',
        'Vue.js',
        'Angular',
        'Svelte',
        'Next.js/Nuxt.js',
      ],
      color: Color(0xFFEC407A),
      icon: Icons.widgets,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Frontend Development Roadmap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: roadmapCategories.map((category) {
            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: _buildRoadmapCategoryCard(category, isDarkMode),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRoadmapCategoryCard(RoadmapCategory category, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        _showCategoryDetailsBottomSheet(category);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    category.icon,
                    color: category.color,
                    size: 32,
                  ),
                ),
                Text(
                  'Details',
                  style: TextStyle(
                    color: category.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Title
            Text(
              category.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Description
            Text(
              category.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDetailsBottomSheet(RoadmapCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: category.color,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(category.icon, color: Colors.white, size: 32),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            category.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      padding: EdgeInsets.all(16),
                      children: [
                        Text(
                          category.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 16),
                        ...category.subtopics.map((subtopic) {
                          return ListTile(
                            title: Text(subtopic),
                            leading: Icon(Icons.check_circle_outline, color: category.color),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

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