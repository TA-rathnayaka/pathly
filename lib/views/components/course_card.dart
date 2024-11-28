import 'package:pathly/config/app_theme.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;

  CourseCard({
    Key? key,
    required this.title,
    required this.count,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 140.0,
            width: 250.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: isDarkMode
                ? AppTextStyles.categoryTitleDark
                : AppTextStyles.categoryTitleLight,
          ),
          SizedBox(height: 4),
          Text(
            "$count Courses",
            style: isDarkMode
                ? AppTextStyles.subheadingDark
                : AppTextStyles.subheadingLight,
          ),
        ],
      ),
    );
  }
}