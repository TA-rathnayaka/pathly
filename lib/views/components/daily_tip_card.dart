import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';


class DailyTipCard extends StatelessWidget {
  final String title;
  final String description;

  const DailyTipCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black, // Title color
              fontSize: 18.0, // Font size for the title
              fontWeight: FontWeight.bold, // Bold font weight
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black87, // Description color
              fontSize: 14.0, // Font size for the description
              fontWeight: FontWeight.normal, // Normal font weight
            ),
          ),
        ],
      ),
    );
  }
}
