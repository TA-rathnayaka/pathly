import 'package:flutter/material.dart';

// Define common colors for both light and dark modes
class AppColors {
  static const Color lightBackground = Color(0xfffafdff);
  static const Color darkBackground = Color(0xFF303030);
  static const Color lightAccent = Color(0xffE7FFFF);
  static const Color darkAccent = Color(0xFF3a3a3a);
  static const Color lightCard = Color(0xffeef1f3);
  static const Color darkCard = Color(0xFF444444);
  static const Color darkGrey = Color(0xFF444444);

  static const Color lightText = Colors.black;
  static const Color darkText = Colors.white;
  static const Color lightSubtitle = Colors.black54;
  static const Color darkSubtitle = Colors.white70;
}

// Define text styles for consistent typography
class AppTextStyles {
  static TextStyle headingLight = const TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static TextStyle headingDark = const TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static TextStyle subheadingLight = const TextStyle(
    color: Colors.black38,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subheadingDark = TextStyle(
    color: Colors.grey[300]!,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle searchHintLight = const TextStyle(
    fontSize: 18,
    color: Colors.black45,
    fontWeight: FontWeight.w600,
  );

  static TextStyle searchHintDark = const TextStyle(
    fontSize: 18,
    color: Colors.white70,
    fontWeight: FontWeight.w600,
  );

  static TextStyle categoryTitleLight = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle categoryTitleDark = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle seeAllLight = TextStyle(
    color: Colors.grey[500]!,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle seeAllDark = TextStyle(
    color: Colors.grey[400]!,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

}