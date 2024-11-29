import 'package:flutter/material.dart';
import 'package:pathly/views/components/tech_path_list.dart'; // Import for TechPathList component
import 'package:pathly/views/components/tech_card.dart'; // Import for TechCard component

class TechPathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tech Path Progress")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TechPathList(
          groupTitle: 'Tech Paths',
          techCards: [
            TechCard(
              icon: Icons.code,
              title: 'Flutter Development',
              subtitle: 'Build beautiful mobile apps.',
              iconBackgroundColor: Colors.blue.withOpacity(0.1),
              iconColor: Colors.blue,
              onTap: () {},
            ),
            TechCard(
              icon: Icons.web,
              title: 'Web Development',
              subtitle: 'Learn modern web technologies.',
              iconBackgroundColor: Colors.green.withOpacity(0.1),
              iconColor: Colors.green,
              onTap: () {},
            ),
            // Add more TechCard items here as needed
          ],
        ),
      ),
    );
  }
}