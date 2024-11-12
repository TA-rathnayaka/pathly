import 'package:flutter/material.dart';

class FrontendRoadmapPage extends StatelessWidget {
  static final String id = '/frontend_roadmap_page';

  final List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'HTML & CSS Basics',
      'description':
          'Start with HTML and CSS to build the structure and style of a webpage.',
      'resources': ['W3Schools', 'MDN Web Docs', 'Codecademy']
    },
    {
      'title': 'JavaScript Essentials',
      'description': 'Learn JavaScript fundamentals to add interactivity.',
      'resources': ['JavaScript.info', 'Eloquent JavaScript', 'FreeCodeCamp']
    },
    {
      'title': 'Version Control (Git)',
      'description': 'Understand the basics of Git to manage your codebase.',
      'resources': ['GitHub Guides', 'Pro Git Book', 'Git Basics']
    },
    {
      'title': 'Frontend Framework (React)',
      'description': 'Dive into React to efficiently build user interfaces.',
      'resources': ['React Docs', 'React Tutorials', 'Scrimba']
    },
    {
      'title': 'Responsive Design & CSS Frameworks',
      'description':
          'Use responsive design techniques and explore frameworks like Bootstrap and Tailwind.',
      'resources': [
        'Responsive Design Basics',
        'Bootstrap Docs',
        'Tailwind Docs'
      ]
    },
    {
      'title': 'API Integration',
      'description':
          'Learn how to work with RESTful APIs and fetch data from external sources.',
      'resources': ['REST API Tutorial', 'Postman', 'Axios']
    },
    {
      'title': 'Advanced JavaScript (ES6+)',
      'description':
          'Get familiar with modern JavaScript features such as ES6, async/await, and more.',
      'resources': ['You Don’t Know JS', 'ES6 Features', 'JavaScript ES6']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('Frontend Development Roadmap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: roadmapStages.length,
          itemBuilder: (context, index) {
            final stage = roadmapStages[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    stage['description'],
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Resources:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      stage['resources'].length,
                      (resourceIndex) => Text(
                        '• ${stage['resources'][resourceIndex]}',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic here to navigate to each specific topic's detailed page
                    },
                    child: Text('Learn More'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
