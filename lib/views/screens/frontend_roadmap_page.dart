import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pathly/models/roadmap_cat.dart';
import 'package:pathly/views/components/roadmap_category_card.dart';

class FrontendRoadmapScreen extends StatefulWidget {
  static const String id = '/frontend_roadmap_screen';

  @override
  _FrontendRoadmapScreenState createState() => _FrontendRoadmapScreenState();
}

class _FrontendRoadmapScreenState extends State<FrontendRoadmapScreen> {
  final List<RoadmapCategory> roadmapCategories = [

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
    RoadmapCategory(
      title: 'Responsive Web Design',
      description: 'Ensure websites look great on any device',
      subtopics: [
        'Media Queries',
        'Flexbox',
        'Grid Layout',
        'Mobile-First Design',
        'Cross-Browser Compatibility',
      ],
      color: Color(0xFF26A69A),
      icon: Icons.mobile_friendly,
    ),
    RoadmapCategory(
      title: 'APIs and RESTful Services',
      description: 'Learn how to interact with backend services',
      subtopics: [
        'What are APIs?',
        'REST Architecture',
        'CRUD Operations',
        'Postman/Insomnia',
        'Error Handling in APIs',
      ],
      color: Color(0xFFAB47BC),
      icon: Icons.cloud,
    ),
    RoadmapCategory(
      title: 'Web Performance Optimization',
      description: 'Make websites load faster and perform better',
      subtopics: [
        'Lazy Loading',
        'Image Optimization',
        'Minification',
        'Caching Strategies',
        'Performance Metrics',
      ],
      color: Color(0xFFFF7043),
      icon: Icons.speed,
    ),
    RoadmapCategory(
      title: 'Testing and Debugging',
      description: 'Ensure reliability with proper testing techniques',
      subtopics: [
        'Debugging Tools',
        'Unit Testing with Jest',
        'Integration Testing',
        'End-to-End Testing with Cypress',
        'Browser Developer Tools',
      ],
      color: Color(0xFF66BB6A),
      icon: Icons.bug_report,
    ),
    RoadmapCategory(
      title: 'Web Security Basics',
      description: 'Protect web applications from vulnerabilities',
      subtopics: [
        'HTTPS and SSL/TLS',
        'CORS',
        'CSRF & XSS Attacks',
        'Authentication & Authorization',
        'OWASP Top 10',
      ],
      color: Color(0xFFE53935),
      icon: Icons.security,
    ),
    RoadmapCategory(
      title: 'Build Tools and Automation',
      description: 'Streamline development workflows',
      subtopics: [
        'Webpack Basics',
        'Babel',
        'Parcel',
        'Task Runners (Gulp/Grunt)',
        'Code Linters & Formatters',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.build,
    ),
    RoadmapCategory(
      title: 'Progressive Web Apps (PWAs)',
      description: 'Build apps with native-like features',
      subtopics: [
        'What are PWAs?',
        'Service Workers',
        'Web App Manifest',
        'Offline Caching',
        'Push Notifications',
      ],
      color: Color(0xFFEF5350),
      icon: Icons.app_registration,
    ),
    RoadmapCategory(
      title: 'Soft Skills for Developers',
      description: 'Improve teamwork and communication',
      subtopics: [
        'Effective Communication',
        'Time Management',
        'Collaboration Tools (Slack/Trello)',
        'Handling Feedback',
        'Writing Documentation',
      ],
      color: Color(0xFF8D6E63),
      icon: Icons.group,
    ),



    // Add other categories similarly...
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
              child: RoadmapCategoryCard(
                category: category,
                isDarkMode: isDarkMode,
                onTap: () => _showCategoryDetailsBottomSheet(category),
              ),
            );
          }).toList(),
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