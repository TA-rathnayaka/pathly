import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pathly/models/roadmap_cat.dart';
import 'package:pathly/data/roadmap_data.dart';

class RoadmapScreen extends StatefulWidget {
  final String roadmapKey;

  const RoadmapScreen({Key? key, required this.roadmapKey}) : super(key: key);

  @override
  _RoadmapScreenState createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  List<RoadmapCategory>? selectedRoadmapCategories;

  @override
  void initState() {
    super.initState();
    print('Received roadmap key: ${widget.roadmapKey}');  // Debug print
    selectedRoadmapCategories = roadmapData[widget.roadmapKey];
    print('Selected categories: $selectedRoadmapCategories');  // Debug print
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        title: Text('${widget.roadmapKey} Roadmap'),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: selectedRoadmapCategories == null
          ? Center(child: Text('Roadmap not found!'))
          : SingleChildScrollView( // Wrapping the body with a scrollable widget
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: selectedRoadmapCategories!.map((category) {
              return GestureDetector(
                onTap: () => _showCategoryDetailsBottomSheet(category),
                child: RoadmapCategoryCard(category: category, isDarkMode: isDarkMode),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showCategoryDetailsBottomSheet(RoadmapCategory category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ListView(
                controller: controller,
                children: [
                  Text(
                    category.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ...category.subtopics.map((subtopic) => ListTile(
                    title: Text(subtopic),
                    leading: Icon(Icons.check_circle_outline, color: category.color),
                  )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class RoadmapCategoryCard extends StatelessWidget {
  final RoadmapCategory category;
  final bool isDarkMode;

  const RoadmapCategoryCard({
    Key? key,
    required this.category,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: category.color.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(category.icon, size: 32, color: category.color),
          SizedBox(height: 16.0),
          Text(
            category.title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            category.description,
            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
