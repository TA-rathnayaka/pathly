import 'package:flutter/material.dart';
import 'package:pathly/views/screens/frontend_roadmap_page.dart';

class TechPathsScreen extends StatelessWidget {
  static final String id = '/tech_paths_screen';

  final List<Map<String, dynamic>> techPaths = [
    {
      'name': 'Frontend Development',
      'route': FrontendRoadmapScreen.id,
      'icon': Icons.web,
      'description':
          'Master UI/UX, HTML, CSS, JavaScript and modern frameworks',
      'progress': 0.0,
      'color': Color(0xFF9FE870),
    },
    {
      'name': 'Backend Development',
      'route': '/backend_roadmap',
      'icon': Icons.dns_rounded,
      'description': 'Learn server-side programming, databases, and APIs',
      'progress': 0.0,
      'color': Color(0xFF70E8E8),
    },
    {
      'name': 'Data Science',
      'route': '/data_science_roadmap',
      'icon': Icons.analytics_rounded,
      'description': 'Explore data analysis, machine learning, and AI',
      'progress': 0.0,
      'color': Color(0xFFFFA570),
    },
    {
      'name': 'Mobile Development',
      'route': '/mobile_roadmap',
      'icon': Icons.smartphone_rounded,
      'description': 'Build iOS and Android apps with modern frameworks',
      'progress': 0.0,
      'color': Color(0xFFFF70B4),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF2A2A2A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                      ),

                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Career Paths',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Choose your learning journey',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Implement search functionality
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Career Paths Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: techPaths.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, techPaths[index]['route']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: techPaths[index]['color'].withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: techPaths[index]['color']
                                      .withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  techPaths[index]['icon'],
                                  color: techPaths[index]['color'],
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                techPaths[index]['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  techPaths[index]['description'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Color(0xFF3A3A3A),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: techPaths[index]['progress'],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: techPaths[index]['color'],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button for quick navigation
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF9FE870),
        child: Icon(Icons.explore, color: Color(0xFF1A1A1A)),
        onPressed: () {
          // Implement quick path finder or recommendation feature
        },
      ),
    );
  }
}
