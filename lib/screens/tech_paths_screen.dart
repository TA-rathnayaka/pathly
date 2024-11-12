import 'package:flutter/material.dart';
import 'package:pathly/screens/frontend_rodamap_page.dart';

class TechPathsScreen extends StatelessWidget {
  static final String id = '/tech_paths_screen';

  final List<Map<String, dynamic>> techPaths = [
    {'title': 'FRONTEND', 'route': FrontendRoadmapPage.id},
    {
      'title': 'BACKEND',
      'route': '/backend_roadmap_page'
    }, // Placeholder, add actual pages later
    {'title': 'DATA SCIENCE', 'route': '/data_science_roadmap_page'},
    {'title': 'NETWORKING', 'route': '/networking_roadmap_page'},
    {'title': 'CYBER SECURITY', 'route': '/cyber_security_roadmap_page'},
    {'title': 'DEVOPS', 'route': '/devops_roadmap_page'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10),
                Text(
                  'Follow your passion',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Explore learning paths and enhance your skills in various fields.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Tech paths list section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: techPaths.length,
                      itemBuilder: (context, index) {
                        final path = techPaths[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              // Black square placeholder
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black,
                                child: Icon(
                                  Icons.computer, // Icon representing tech path
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 15),
                              // Tech path name
                              Expanded(
                                child: Text(
                                  path['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // Start button
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, path['route']);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Start',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Bottom navigation
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.home_outlined),
                          onPressed: () {
                            // Navigate to Home
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.article_outlined),
                          onPressed: () {
                            // Navigate to Articles
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.grid_view),
                          onPressed: () {
                            // Navigate to Courses/Resources
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.person_outline),
                          onPressed: () {
                            // Navigate to Profile
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
