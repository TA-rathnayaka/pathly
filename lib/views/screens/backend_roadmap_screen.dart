import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pathly/models/roadmap_cat.dart';
import 'package:pathly/views/components/roadmap_category_card.dart';

class BackendRoadmapScreen extends StatefulWidget {
  static const String id = '/backend_screen';

  @override
  _BackendRoadmapScreenState createState() => _BackendRoadmapScreenState();
}

class _BackendRoadmapScreenState extends State<BackendRoadmapScreen> {
  final List<RoadmapCategory> roadmapCategories = [
    RoadmapCategory(
      title: 'Backend Basics',
      description: 'Learn the fundamentals of backend development',
      subtopics: [
        'HTTP & HTTPS',
        'RESTful APIs',
        'CRUD Operations',
        'MVC Architecture',
        'Database Design',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.api,
    ),
    RoadmapCategory(
      title: 'Databases & SQL',
      description: 'Manage data with databases and SQL',
      subtopics: [
        'Relational Databases',
        'SQL Queries',
        'Normalization',
        'Indexes & Optimization',
        'Database Security',
      ],
      color: Color(0xFF66BB6A),
      icon: Icons.storage,
    ),
    RoadmapCategory(
      title: 'Server-Side Programming',
      description: 'Master server-side languages and frameworks',
      subtopics: [
        'Node.js & Express',
        'Python & Django/Flask',
        'Java & Spring Boot',
        'Ruby on Rails',
        'PHP & Laravel',
      ],
      color: Color(0xFF9C27B0),
      icon: Icons.code,
    ),
    RoadmapCategory(
      title: 'Authentication & Authorization',
      description: 'Secure your applications with proper authentication',
      subtopics: [
        'JWT Authentication',
        'OAuth2',
        'Session Management',
        'Role-Based Access Control',
        'Password Hashing & Salting',
      ],
      color: Color(0xFFE53935),
      icon: Icons.security,
    ),
    RoadmapCategory(
      title: 'API Development & Integration',
      description: 'Create and integrate APIs effectively',
      subtopics: [
        'REST vs. GraphQL',
        'Building REST APIs',
        'Third-Party API Integration',
        'Rate Limiting & Caching',
        'API Documentation with Swagger',
      ],
      color: Color(0xFFFF7043),
      icon: Icons.cloud,
    ),
    RoadmapCategory(
      title: 'Message Queues & Asynchronous Programming',
      description: 'Handle background tasks and asynchronous workflows',
      subtopics: [
        'RabbitMQ/Kafka',
        'Message Queues in APIs',
        'Async Programming in Node.js',
        'Background Jobs & Cron Jobs',
        'Worker Processes',
      ],
      color: Color(0xFFAB47BC),
      icon: Icons.mail,
    ),
    RoadmapCategory(
      title: 'Cloud Computing & Hosting',
      description: 'Deploy applications on the cloud',
      subtopics: [
        'AWS (EC2, S3, Lambda)',
        'Azure',
        'Google Cloud Platform',
        'Heroku & DigitalOcean',
        'Docker & Kubernetes',
      ],
      color: Color(0xFF26A69A),
      icon: Icons.cloud_queue,
    ),
    RoadmapCategory(
      title: 'WebSockets & Real-Time Communication',
      description: 'Build real-time web applications',
      subtopics: [
        'WebSocket Protocol',
        'Socket.io (Node.js)',
        'Real-time Messaging',
        'Push Notifications',
        'Chat Applications',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.chat_bubble,
    ),
    RoadmapCategory(
      title: 'Testing & Debugging',
      description: 'Ensure backend reliability with testing techniques',
      subtopics: [
        'Unit Testing (JUnit, Mocha)',
        'Integration Testing',
        'Test-Driven Development (TDD)',
        'Mocking & Stubbing',
        'Error Handling & Logging',
      ],
      color: Color(0xFF66BB6A),
      icon: Icons.bug_report,
    ),
    RoadmapCategory(
      title: 'Microservices & Serverless',
      description: 'Design scalable systems with microservices',
      subtopics: [
        'Microservices Architecture',
        'Serverless Framework',
        'Event-Driven Design',
        'Service Discovery',
        'API Gateway & Load Balancers',
      ],
      color: Color(0xFF9C27B0),
      icon: Icons.account_tree,
    ),
    RoadmapCategory(
      title: 'Security & Performance',
      description: 'Optimize performance and secure your backend',
      subtopics: [
        'OWASP Top 10',
        'SQL Injection & XSS Protection',
        'Caching Strategies',
        'Database Optimization',
        'Rate Limiting & Security Headers',
      ],
      color: Color(0xFFE53935),
      icon: Icons.security,
    ),
    RoadmapCategory(
      title: 'DevOps & CI/CD',
      description: 'Automate deployment and integrate continuous testing',
      subtopics: [
        'GitHub Actions & GitLab CI',
        'Docker & Kubernetes',
        'Continuous Integration',
        'Continuous Delivery & Deployment',
        'Monitoring & Logging',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.build,
    ),
    RoadmapCategory(
      title: 'Soft Skills for Developers',
      description: 'Improve teamwork and communication skills',
      subtopics: [
        'Effective Communication',
        'Time Management',
        'Collaboration Tools (Slack/Trello)',
        'Problem Solving',
        'Writing Documentation',
      ],
      color: Color(0xFF8D6E63),
      icon: Icons.group,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Backend Development Roadmap',
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
