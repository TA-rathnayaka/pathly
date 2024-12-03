import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Import youtube_player_flutter
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

  const StageCard({super.key, 
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    this.description,
    this.resourceUrl,
    this.iconSize = 24.0,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  @override
  _StageCardState createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    // Initialize YouTube Player Controller only if resourceUrl is available
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          tileColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.iconSize,
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: widget.description != null
              ? Text(
            widget.description!,
            style: TextStyle(fontSize: 12, color: subtitleColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black54),
                onPressed: widget.onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.black54),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceWidget() {
    if (widget.resourceUrl != null && widget.resourceUrl!.isNotEmpty) {
      if (widget.resourceUrl!.contains('youtube.com') || widget.resourceUrl!.contains('youtu.be')) {
        return _buildYouTubePlayer(widget.resourceUrl!);
      } else if (widget.resourceUrl!.contains('.jpg') || widget.resourceUrl!.contains('.png') || widget.resourceUrl!.contains('.jpeg')) {
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
    final videoId = _extractYouTubeId(url);
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
      await launchUrl(Uri.parse(url));  // Updated launch function for url_launcher
    } else {
      throw 'Could not launch $url';
    }
  }
}