import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FrontendRoadmapScreen extends StatefulWidget {
  static final String id = '/frontend_roadmap_screen';

  @override
  _FrontendRoadmapScreenState createState() => _FrontendRoadmapScreenState();
}

class _FrontendRoadmapScreenState extends State<FrontendRoadmapScreen> {
  late ConfettiController _confettiController;
  int totalXP = 0;
  int currentLevel = 1;

  // Sample roadmap stages with gamification elements
  List<Map<String, dynamic>> roadmapStages = [
    {
      'title': 'HTML & CSS Basics',
      'description':
          'Start with HTML and CSS to build the structure and style of a webpage.',
      'resources': ['W3Schools', 'MDN Web Docs', 'Codecademy'],
      'completed': false,
      'xp': 100,
      'level': 1,
      'icon': Icons.code,
      'achievements': [
        {
          'name': 'HTML Hero',
          'description': 'Complete all HTML exercises',
          'unlocked': false
        },
        {
          'name': 'CSS Master',
          'description': 'Style your first webpage',
          'unlocked': false
        },
      ],
      'progress': 0.0,
      'color': Color(0xFF9FE870),
      'prerequisites': [],
    },
    {
      'title': 'JavaScript Essentials',
      'description': 'Learn JavaScript fundamentals to add interactivity.',
      'resources': ['JavaScript.info', 'Eloquent JavaScript', 'FreeCodeCamp'],
      'completed': false,
      'xp': 150,
      'level': 2,
      'icon': Icons.javascript,
      'achievements': [
        {
          'name': 'Code Ninja',
          'description': 'Write your first function',
          'unlocked': false
        },
        {
          'name': 'Debug Master',
          'description': 'Fix 5 bugs',
          'unlocked': false
        },
      ],
      'progress': 0.0,
      'color': Color(0xFF70E8E8),
      'prerequisites': ['HTML & CSS Basics'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _updateProgress(int index, double progress) {
    setState(() {
      roadmapStages[index]['progress'] = progress;
      if (progress >= 1.0 && !roadmapStages[index]['completed']) {
        roadmapStages[index]['completed'] = true;
        totalXP += (roadmapStages[index]['xp'] as int);
        _confettiController.play();
        _checkLevelUp();
      }
    });
  }

  void _checkLevelUp() {
    int newLevel = (totalXP / 100).floor() + 1;
    if (newLevel > currentLevel) {
      setState(() {
        currentLevel = newLevel;
      });
      _showLevelUpDialog();
    }
  }

  void _showLevelUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Color(0xFF9FE870), size: 50),
            SizedBox(height: 16),
            Text(
              'Level Up!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'You reached level $currentLevel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  void _showSkillTree() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Skill Tree',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(24),
                children: roadmapStages
                    .map((stage) => ListTile(
                          title: Text(stage['title'],
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                            '${stage['xp']} XP - Level ${stage['level']}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Icon(
                            stage['completed']
                                ? Icons.check_circle
                                : Icons.lock,
                            color:
                                stage['completed'] ? Colors.green : Colors.red,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStageDetails(Map<String, dynamic> stage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(stage['title']),
        content: Text(stage['description']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1A1A), Color(0xFF2A2A2A)],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header with level and XP
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _showSkillTree,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color(0xFF9FE870), width: 2),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Color(0xFF9FE870), size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Level $currentLevel',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xFF2A2A2A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.flash_on,
                                      color: Colors.amber, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    '$totalXP XP',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Roadmap content
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemCount: roadmapStages.length,
                      itemBuilder: (context, index) {
                        final stage = roadmapStages[index];
                        final isLocked = stage['prerequisites'].any(
                          (prereq) => !roadmapStages.firstWhere(
                              (s) => s['title'] == prereq)['completed'],
                        );

                        return Container(
                          margin: EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: stage['color'].withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: isLocked
                                    ? null
                                    : () => _showStageDetails(stage),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: stage['color']
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              stage['icon'],
                                              color: stage['color'],
                                              size: 28,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              stage['title'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (stage['completed'])
                                            Icon(Icons.check_circle,
                                                color: Color(0xFF9FE870)),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        stage['description'],
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 16),
                                      CircularPercentIndicator(
                                        radius: 40,
                                        lineWidth: 6,
                                        percent: stage['progress'],
                                        center: Text(
                                          '${(stage['progress'] * 100).toStringAsFixed(0)}%',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        progressColor: stage['color'],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Confetti celebration
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              numberOfParticles: 30,
              gravity: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
