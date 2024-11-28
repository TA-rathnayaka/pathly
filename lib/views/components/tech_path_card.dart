import 'package:flutter/material.dart';

class TechPathCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final double progress;
  final VoidCallback onTap;

  const TechPathCard({
    Key? key,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Set colors based on theme
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;
    final backgroundColor = isDarkMode ? Color(0xFF2A2A2A) : Colors.white;
    final borderColor = isDarkMode ? color.withOpacity(0.3) : color.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Rounded corners like SettingsItem
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          tileColor: backgroundColor, // Background color based on theme
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1), // Light background behind icon
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor, // Title color based on theme
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: subtitleColor, // Subtitle color based on theme
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[300], // Progress bar background
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color, // Progress color
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}