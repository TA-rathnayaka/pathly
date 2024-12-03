import 'package:flutter/material.dart';

class TechCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double iconSize;
  final Color iconBackgroundColor;
  final Color iconColor;

  const TechCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.trailing,
    this.onTap,
    this.onEdit,
    this.onDelete,
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
      onTap: onTap,
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
            style: titleStyle ??
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: subtitle != null
              ? Text(
            subtitle!,
            style: subtitleStyle ?? TextStyle(fontSize: 12, color: subtitleColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
              : null,
          trailing: trailing ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black54),
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black54),
                      onPressed: onDelete,
                    ),
                ],
              ),
        ),
      ),
    );
  }
}