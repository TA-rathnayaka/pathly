import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';  // Import the provider
import 'package:pathly/views/screens/stages_screen.dart';    // Assuming this is the screen to show stages
import 'package:pathly/views/components/tech_path_list.dart'; // Import for TechPathList component
import 'package:pathly/views/components/tech_card.dart'; // Import for TechCard component

class CreatePathScreen extends StatelessWidget {
  static final String id = '/create_path';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();  // Added description controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData _selectedIcon = Icons.star;  // Default icon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Roadmap')),
      body: SingleChildScrollView(  // Wrap the content in a scrollable widget
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to add a new roadmap title, description, and icon
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // TextFormField for entering the title
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Enter Roadmap Title',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // TextFormField for entering the description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Enter Roadmap Description',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Icon picker (Simple icon selection)
                  DropdownButton<IconData>(
                    value: _selectedIcon,
                    onChanged: (IconData? newIcon) {
                      if (newIcon != null) {
                        _selectedIcon = newIcon;
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: Icons.star,
                        child: Icon(Icons.star),
                      ),
                      DropdownMenuItem(
                        value: Icons.check_circle,
                        child: Icon(Icons.check_circle),
                      ),
                      DropdownMenuItem(
                        value: Icons.thumb_up,
                        child: Icon(Icons.thumb_up),
                      ),
                      // Add more icons as needed
                    ],
                    hint: Text('Select an Icon'),
                  ),
                  SizedBox(height: 20),

                  // Button to add the title, description, and icon, and navigate
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final title = _titleController.text;
                        final description = _descriptionController.text;

                        // Add the new roadmap to the provider
                        Provider.of<RoadmapProvider>(context, listen: false)
                            .addRoadmap(title, description, _selectedIcon);

                        // Clear the input fields
                        _titleController.clear();
                        _descriptionController.clear();
                      }
                    },
                    child: Text('Add Roadmap'),
                  ),
                ],
              ),
            ),

            // Display list of roadmaps using TechPathList and TechCard components
            SizedBox(height: 20),
            Text(
              'Roadmap Titles:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Consumer widget to listen for updates in the roadmap list
            Consumer<RoadmapProvider>(
              builder: (context, roadmapProvider, child) {
                return TechPathList(
                  groupTitle: 'Roadmap Paths',
                  techCards: roadmapProvider.roadmaps.map((roadmap) {
                    return TechCard(
                      icon: roadmap.icon,
                      title: roadmap.title,
                      subtitle: roadmap.description,
                      iconBackgroundColor: Colors.blue.withOpacity(0.1),  // Customize as needed
                      iconColor: Colors.blue,  // Customize as needed
                      onTap: () {
                        // Navigate to the stages screen with the selected title
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StagePage(title: roadmap.title),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}