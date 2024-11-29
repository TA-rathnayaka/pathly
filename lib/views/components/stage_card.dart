import 'package:flutter/material.dart';

class StageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final double iconSize;
  final Color iconBackgroundColor;
  final Color iconColor;

  StageCard({
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    this.description,
    this.iconSize = 24.0,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

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
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: description != null
              ? Text(
            description!,
            style: TextStyle(fontSize: 12, color: subtitleColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black54),
                onPressed: onEdit, // Trigger edit functionality
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.black54),
                onPressed: onDelete, // Trigger delete functionality
              ),
            ],
          ),
        ),
      ),
    );
  }
}