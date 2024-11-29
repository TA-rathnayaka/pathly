import 'package:flutter/material.dart';
import 'package:pathly/views/components/tech_path_list.dart'; // Import for TechPathList component
import 'package:pathly/views/components/tech_card.dart'; // Import for TechCard component
import 'package:provider/provider.dart'; // For accessing providers
import 'package:pathly/models/roadmap.dart'; // Import Roadmap model
import 'package:pathly/providers/roadmap_provider.dart'; // Import RoadmapProvider
import 'package:pathly/providers/user_provider.dart'; // Import UserProvider

class TechPathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listen to the UserProvider to get enrolled roadmaps
    return Scaffold(
      appBar: AppBar(title: Text("Tech Path Progress")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.enrolledRoadmapIds.isEmpty) {
              return Center(
                child: Text('You are not enrolled in any roadmaps.'),
              );
            }

            // Fetch roadmaps based on enrolled IDs
            return Consumer<RoadmapProvider>(
              builder: (context, roadmapProvider, child) {
                return FutureBuilder<List<Roadmap>>(
                  future: _fetchEnrolledRoadmaps(userProvider.enrolledRoadmapIds, roadmapProvider),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No roadmaps found.'));
                    }

                    // Display enrolled roadmaps
                    List<Roadmap> roadmaps = snapshot.data!;
                    return TechPathList(
                      groupTitle: 'Tech Paths',
                      techCards: roadmaps.map((roadmap) {
                        return TechCard(
                          icon: roadmap.icon ?? Icons.code,
                          title: roadmap.title,
                          subtitle: roadmap.description ?? 'No description available.',
                          iconBackgroundColor: Colors.blue.withOpacity(0.1),
                          iconColor: Colors.blue,
                          onTap: () {
                            // Handle tap on roadmap (navigate or show details)
                          },
                        );
                      }).toList(),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Roadmap>> _fetchEnrolledRoadmaps(
      List<String> enrolledRoadmapIds, RoadmapProvider roadmapProvider) async {
    List<Roadmap> roadmaps = [];
    for (var roadmapId in enrolledRoadmapIds) {
      try {
        final roadmap = await roadmapProvider.getRoadmap(roadmapId);
        roadmaps.add(roadmap);
      } catch (e) {
        print('Error fetching roadmap: $e');
      }
    }
    return roadmaps;
  }
}