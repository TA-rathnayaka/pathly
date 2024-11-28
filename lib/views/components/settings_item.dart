import 'package:pathly/views/components/icon_style.dart';
import 'package:pathly/views/components/settings_screen_utils.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final int? titleMaxLine;
  final int? subtitleMaxLine;
  final TextOverflow? overflow;

  SettingsItem({
    required this.icons,
    this.iconStyle,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.trailing,
    this.onTap,
    this.titleMaxLine,
    this.subtitleMaxLine,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        onTap: onTap,
        leading: (iconStyle != null && iconStyle!.withBackground!)
            ? Container(
          decoration: BoxDecoration(
            color: iconStyle!.backgroundColor,
            borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
          ),
          padding: EdgeInsets.all(5),
          child: Icon(
            icons,
            size: SettingsScreenUtils.settingsGroupIconSize,
            color: iconStyle!.iconsColor,
          ),
        )
            : Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            icons,
            size: SettingsScreenUtils.settingsGroupIconSize,
            color: isDarkMode ? Colors.white : Colors.black, // Icon color based on theme
          ),
        ),
        title: Text(
          title,
          style: titleStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor, // Title text color based on theme
              ),
          maxLines: titleMaxLine,
          overflow: titleMaxLine != null ? overflow : null,
        ),
        subtitle: (subtitle != null)
            ? Text(
          subtitle!,
          style: subtitleStyle ??
              TextStyle(
                color: subtitleColor, // Subtitle text color based on theme
              ),
          maxLines: subtitleMaxLine,
          overflow: subtitleMaxLine != null ? TextOverflow.ellipsis : null,
        )
            : null,
        trailing: trailing ?? Icon(Icons.navigate_next, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}