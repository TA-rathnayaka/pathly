import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class StageCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final double iconSize;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String? resourceUrl;

  const StageCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    this.description,
    this.resourceUrl,
    this.iconSize = 32.0,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  @override
  _StageCardState createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  late YoutubePlayerController _youtubePlayerController;

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _resourceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.resourceUrl != null && widget.resourceUrl!.contains('youtube.com')) {
      final videoId = _extractYouTubeId(widget.resourceUrl!);
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  @override
  void dispose() {
    if (widget.resourceUrl != null && widget.resourceUrl!.contains('youtube.com')) {
      _youtubePlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return GestureDetector(
      onTap: () {
        // Show bottom sheet when tapped
        _showBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(
          minHeight: 200.0, // Set minimum height to make the card taller
        ),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: widget.iconColor,
                  ),
                ),
                const Spacer(),
                // Edit and Delete Buttons
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: widget.onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8.0),
            // Description
            if (widget.description != null)
              Text(
                widget.description!,
                style: TextStyle(
                  fontSize: 14.0,
                  color: subtitleColor,
                ),
              ),
            const SizedBox(height: 16.0),
            // Resource Section
            Expanded(
              child: _buildResourceWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceWidget() {
    if (widget.resourceUrl != null && widget.resourceUrl!.isNotEmpty) {
      if (widget.resourceUrl!.contains('youtube.com') || widget.resourceUrl!.contains('youtu.be')) {
        return _buildYouTubePlayer(widget.resourceUrl!);
      } else if (widget.resourceUrl!.endsWith('.jpg') ||
          widget.resourceUrl!.endsWith('.png') ||
          widget.resourceUrl!.endsWith('.jpeg')) {
        return Image.network(widget.resourceUrl!);
      } else if (widget.resourceUrl!.startsWith('http')) {
        return GestureDetector(
          onTap: () => _launchURL(widget.resourceUrl!),
          child: const Text(
            'Open Resource',
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
        );
      }
    }
    return Container();
  }

  Widget _buildYouTubePlayer(String url) {
    return YoutubePlayer(
      controller: _youtubePlayerController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blue,
    );
  }

  String _extractYouTubeId(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Task and Resource URL',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Task input field
              TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Resource URL input field
              TextField(
                controller: _resourceController,
                decoration: const InputDecoration(
                  labelText: 'Resource URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add task and resource URL logic here
                  final task = _taskController.text;
                  final resourceUrl = _resourceController.text;
                  // You can now use these values outside the widget
                  print('Task: $task');
                  print('Resource URL: $resourceUrl');
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}