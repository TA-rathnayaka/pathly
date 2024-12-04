import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SubtaskScreen extends StatefulWidget {
  @override
  _SubtaskScreenState createState() => _SubtaskScreenState();
}

class _SubtaskScreenState extends State<SubtaskScreen> {
  final List<Map<String, String>> _subtasks = [];

  void _showAddSubtaskBottomSheet() {
    final titleController = TextEditingController();
    final resourceUrlController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Subtask Title'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: resourceUrlController,
              decoration: const InputDecoration(labelText: 'Resource URL'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final resourceUrl = resourceUrlController.text.trim();

                if (title.isNotEmpty) {
                  setState(() {
                    _subtasks.add({'title': title, 'resourceUrl': resourceUrl});
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Subtask'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceWidget(String resourceUrl) {
    if (resourceUrl.contains('youtube.com') || resourceUrl.contains('youtu.be')) {
      final videoId = _extractYouTubeId(resourceUrl);
      return Image.network(
        'https://img.youtube.com/vi/$videoId/0.jpg', // YouTube thumbnail
        fit: BoxFit.cover,
      );
    } else if (resourceUrl.endsWith('.jpg') ||
        resourceUrl.endsWith('.png') ||
        resourceUrl.endsWith('.jpeg')) {
      return Image.network(resourceUrl, fit: BoxFit.cover);
    } else {
      return const Text('Unsupported resource type');
    }
  }

  String _extractYouTubeId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subtasks'),
      ),
      body: ListView.builder(
        itemCount: _subtasks.length,
        itemBuilder: (context, index) {
          final subtask = _subtasks[index];
          final title = subtask['title']!;
          final resourceUrl = subtask['resourceUrl']!;

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (resourceUrl.isNotEmpty)
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      child: _buildResourceWidget(resourceUrl),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubtaskBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}