import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';  // Import the provider
import 'package:pathly/views/screens/stages_screen.dart';    // Assuming this is the screen to show stages

class CreatePathScreen extends StatelessWidget {
  static final String id = '/create_path';
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Roadmap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to add a new roadmap title
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

                  // Button to add the title and navigate
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final title = _titleController.text;
                        // Add the new roadmap to the provider
                        Provider.of<RoadmapProvider>(context, listen: false)
                            .addRoadmap(title);

                        // Clear the input field
                        _titleController.clear();

                        // Optionally, you can navigate to a new screen (e.g., StagePage)
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => StagePage(title: title),
                        //   ),
                        // );
                      }
                    },
                    child: Text('Add Title'),
                  ),
                ],
              ),
            ),

            // Display list of roadmaps
            SizedBox(height: 20),
            Text(
              'Roadmap Titles:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Consumer widget to listen for updates in the roadmap list
            Consumer<RoadmapProvider>(
              builder: (context, roadmapProvider, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: roadmapProvider.roadmaps.length,
                    itemBuilder: (context, index) {
                      final roadmap = roadmapProvider.roadmaps[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          title: Text(
                            roadmap.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            // Navigate to StagePage with selected title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StagePage(title: roadmap.title),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}