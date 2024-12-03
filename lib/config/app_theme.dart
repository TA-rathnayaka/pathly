import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static TextStyle headingLight = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );


  static TextStyle pathly = GoogleFonts.roboto(
    color: Colors.lightGreenAccent,
    fontSize: 60,
    fontWeight: FontWeight.w700,
  );



  static TextStyle headingDark = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static TextStyle subheadingLight = GoogleFonts.roboto(
    color: Colors.black38,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subheadingDark = GoogleFonts.roboto(
    color: Colors.grey[300]!,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle searchHintLight = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.black45,
    fontWeight: FontWeight.w600,
  );

  static TextStyle searchHintDark = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.white70,
    fontWeight: FontWeight.w600,
  );

  static TextStyle categoryTitleLight = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle categoryTitleDark = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle seeAllLight = GoogleFonts.roboto(
    color: Colors.grey[500]!,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle seeAllDark = GoogleFonts.roboto(
    color: Colors.grey[400]!,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}