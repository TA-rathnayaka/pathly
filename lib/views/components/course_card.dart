import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;
  final String route;
  final VoidCallback? onPressed;  // Added parameter for the onPressed callback

  const CourseCard({
    super.key,
    required this.title,
    required this.count,
    required this.imagePath,
    required this.route,
    this.onPressed, // Allow optional onPressed parameter
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.center, // Keep the button within the stack
            children: [
              Container(
                height: 140.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagePath.startsWith("http")
                        ? NetworkImage(imagePath) // Use NetworkImage for URLs
                        : AssetImage(imagePath) as ImageProvider, // Use AssetImage for local assets
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Positioned(
                bottom: 10.0,  // Position the button at the bottom
                right: 10.0,   // Position the button to the right
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text("Enroll"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: isDarkMode
                ? AppTextStyles.categoryTitleDark
                : AppTextStyles.categoryTitleLight,
          ),
          const SizedBox(height: 4),
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