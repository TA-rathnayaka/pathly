import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pathly/models/roadmap_cat.dart';
import 'package:pathly/views/components/roadmap_category_card.dart';

class MobileAppDevelopmentRoadmapScreen extends StatefulWidget {
  static const String id = '/mobile_app_development_roadmap_screen';

  @override
  _MobileAppDevelopmentRoadmapScreenState createState() => _MobileAppDevelopmentRoadmapScreenState();
}

class _MobileAppDevelopmentRoadmapScreenState extends State<MobileAppDevelopmentRoadmapScreen> {
  final List<RoadmapCategory> roadmapCategories = [
    RoadmapCategory(
      title: 'Flutter Basics',
      description: 'Learn the fundamentals of building mobile applications with Flutter.',
      subtopics: [
        'Widgets & State Management',
        'Layouts & Navigation',
        'Hot Reload',
        'Flutter DevTools',
        'Basic UI Components',
      ],
      color: Color(0xFF00B0FF),
      icon: Icons.flutter_dash,
    ),
    RoadmapCategory(
      title: 'Android Development',
      description: 'Learn how to develop Android apps using Java or Kotlin.',
      subtopics: [
        'Activity Lifecycle',
        'User Interface Design',
        'RecyclerView',
        'Networking',
        'Database Integration',
      ],
      color: Color(0xFF3DDC84),
      icon: Icons.android,
    ),
    RoadmapCategory(
      title: 'iOS Development',
      description: 'Learn how to build iOS apps using Swift and Xcode.',
      subtopics: [
        'Swift Basics',
        'UIViewController',
        'TableViews',
        'AutoLayout',
        'Networking with URLSession',
      ],
      color: Color(0xFF007AFF),
      icon: Icons.apple,
    ),
    RoadmapCategory(
      title: 'Cross-Platform Development',
      description: 'Learn how to build apps for both Android and iOS with a single codebase.',
      subtopics: [
        'Flutter vs React Native',
        'Firebase for Backend',
        'Shared Codebase Architecture',
        'State Management',
        'Deployment on App Stores',
      ],
      color: Color(0xFFFFB74D),
      icon: Icons.phone_iphone,
    ),
    RoadmapCategory(
      title: 'App UI/UX Design',
      description: 'Learn the principles of mobile app UI/UX design for better user experience.',
      subtopics: [
        'Design Patterns (Material Design, Cupertino)',
        'Responsive Design',
        'User Flow',
        'Prototyping',
        'User Testing',
      ],
      color: Color(0xFF8E24AA),
      icon: Icons.design_services,
    ),
    RoadmapCategory(
      title: 'App Deployment & Publishing',
      description: 'Learn how to deploy and publish your app to the Play Store and App Store.',
      subtopics: [
        'Android App Bundle (AAB)',
        'iOS App Store Guidelines',
        'Play Store Optimization',
        'App Monetization',
        'App Analytics Integration',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.publish,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Mobile App Development Roadmap',
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
