import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/path_provider.dart';

class CreatePathScreen extends StatelessWidget {
  static final String id = '/create_path';

  @override
  Widget build(BuildContext context) {
    final pathState = Provider.of<PathProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Path'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: pathState.pathNameController,
                  decoration: InputDecoration(
                    labelText: 'Path Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a path name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Special Points:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ...pathState.specialPoints.map((point) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(point['title']),
                      subtitle: Text(point['description']),
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        // Handle editing logic here
                      },
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _showAddSpecialPointDialog(context),
                  icon: Icon(Icons.add),
                  label: Text('Add Special Point'),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (pathState.pathNameController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Path created successfully!')),
                      );
                      pathState.clear(); // Reset state after saving
                    }
                  },
                  child: Text('Save Path'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddSpecialPointDialog(BuildContext context) {
    final pathState = Provider.of<PathProvider>(context, listen: false);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final linkController = TextEditingController();
    String? imagePath;
    XFile? video;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Special Point'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: linkController,
                decoration: InputDecoration(labelText: 'Link (Optional)'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedFile = await pathState.picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        imagePath = pickedFile.path;
                      }
                    },
                    icon: Icon(Icons.image),
                    label: Text('Add Image'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedVideo = await pathState.picker.pickVideo(
                        source: ImageSource.gallery,
                      );
                      if (pickedVideo != null) {
                        video = pickedVideo;
                      }
                    },
                    icon: Icon(Icons.video_library),
                    label: Text('Add Video'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                pathState.addSpecialPoint({
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'link': linkController.text,
                  'image': imagePath,
                  'video': video,
                });
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}