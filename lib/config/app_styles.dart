import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:pathly/config/app_theme.dart'; // Ensure you import your AppColors and AppTextStyles

ThemeData getBaseTheme(bool isDarkMode) {
  return ThemeData(
    primarySwatch: Colors.blue,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: Colors.black54, // Primary color can be updated as per requirements
      onPrimary: Colors.white,
      secondary: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
      onSecondary: Colors.white,
      surface: isDarkMode ? AppColors.darkCard : AppColors.lightCard,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    ),
    // Apply Roboto as the default font family
    textTheme: GoogleFonts.robotoTextTheme(),
  );
}

ThemeData getTheme(bool isDarkMode, ThemeData baseTheme) {
  return baseTheme.copyWith(
    scaffoldBackgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
    textTheme: baseTheme.textTheme.copyWith(
      headlineSmall: isDarkMode ? AppTextStyles.headingDark : AppTextStyles.headingLight,
      bodyMedium: isDarkMode ? AppTextStyles.subheadingDark : AppTextStyles.subheadingLight,
      bodyLarge: isDarkMode ? AppTextStyles.searchHintDark : AppTextStyles.searchHintLight,
    ).apply(
      bodyColor: isDarkMode ? Colors.white : Colors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent, // Button color
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: isDarkMode
            ? AppTextStyles.categoryTitleDark.color
            : AppTextStyles.categoryTitleLight.color,
      ),
    ),
  );
}
