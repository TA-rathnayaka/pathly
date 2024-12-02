import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pathly/models/roadmap_cat.dart';
import 'package:pathly/views/components/roadmap_category_card.dart';

class DataScienceRoadmapScreen extends StatefulWidget {
  static const String id = '/data_science_roadmap_screen';

  @override
  _DataScienceRoadmapScreenState createState() =>
      _DataScienceRoadmapScreenState();
}

class _DataScienceRoadmapScreenState extends State<DataScienceRoadmapScreen> {
  final List<RoadmapCategory> roadmapCategories = [
    RoadmapCategory(
      title: 'Python Basics',
      description: 'Learn the fundamentals of Python programming.',
      subtopics: [
        'Variables & Data Types',
        'Control Flow',
        'Functions',
        'Data Structures',
        'File Handling',
        'Error Handling',
      ],
      color: Color(0xFF42A5F5),
      icon: Icons.code,
    ),
    RoadmapCategory(
      title: 'Data Analysis with Pandas',
      description: 'Learn how to analyze data using the Pandas library.',
      subtopics: [
        'DataFrames & Series',
        'Data Cleaning',
        'Data Merging',
        'GroupBy Operations',
        'Visualization with Matplotlib',
        'Handling Missing Data',
      ],
      color: Color(0xFF3949AB),
      icon: Icons.data_usage,
    ),
    RoadmapCategory(
      title: 'Data Visualization',
      description: 'Learn how to create effective visualizations.',
      subtopics: [
        'Matplotlib',
        'Seaborn',
        'Plotly',
        'Tableau Basics',
        'Data Storytelling',
      ],
      color: Color(0xFF26A69A),
      icon: Icons.graphic_eq,
    ),
    RoadmapCategory(
      title: 'Machine Learning Basics',
      description: 'Introduction to machine learning algorithms.',
      subtopics: [
        'Supervised Learning',
        'Unsupervised Learning',
        'Linear Regression',
        'Classification',
        'Clustering',
        'Model Evaluation',
      ],
      color: Color(0xFFFFA726),
      icon: Icons.insert_chart,
    ),
    RoadmapCategory(
      title: 'Deep Learning',
      description: 'Learn about neural networks and deep learning frameworks.',
      subtopics: [
        'Neural Networks Basics',
        'Convolutional Networks',
        'Recurrent Networks',
        'TensorFlow/Keras Basics',
        'Model Training & Evaluation',
        'Transfer Learning',
      ],
      color: Color(0xFF8E24AA),
      icon: Icons.headset,
    ),
    RoadmapCategory(
      title: 'Natural Language Processing (NLP)',
      description: 'Learn how to process and analyze text data.',
      subtopics: [
        'Text Preprocessing',
        'Tokenization & Lemmatization',
        'TF-IDF Vectorization',
        'Sentiment Analysis',
        'Word Embeddings',
      ],
      color: Color(0xFF7E57C2),
      icon: Icons.text_fields,
    ),
    RoadmapCategory(
      title: 'Big Data & Cloud Computing',
      description: 'Introduction to Big Data frameworks and cloud computing tools.',
      subtopics: [
        'Hadoop & Spark Basics',
        'Data Pipelines',
        'Cloud Platforms (AWS, GCP, Azure)',
        'SQL on Big Data',
      ],
      color: Color(0xFF8D6E63),
      icon: Icons.cloud,
    ),
    RoadmapCategory(
      title: 'Data Science Project & Portfolio',
      description: 'Build real-world projects and showcase your portfolio.',
      subtopics: [
        'Kaggle Competitions',
        'End-to-End Projects',
        'GitHub & Version Control',
        'Creating a Portfolio Website',
        'Networking & Community Involvement',
      ],
      color: Color(0xFF00BFAE),
      icon: Icons.business_center,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Data Science Roadmap',
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
