import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF181C22);
  static const Color appbarCard = Color(0xFF232830);
  static const Color primaryText = Color(0xFFF5F5F5);
  static const Color primaryButton = Color(0xFF44AACC);
  static const Color selectedIcon = Color(0xFFF2C94C);
  static const Color errorAlternative = Color(0xFFBB3333);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background, 

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryText),
        bodyMedium: TextStyle(color: AppColors.primaryText),
        titleLarge: TextStyle(color: AppColors.primaryText),
        titleMedium: TextStyle(color: AppColors.primaryText),
        headlineLarge: TextStyle(color: AppColors.primaryText),
        headlineMedium: TextStyle(color: AppColors.primaryText),
        displayLarge: TextStyle(color: AppColors.primaryText),
        displayMedium: TextStyle(color: AppColors.primaryText),
        displaySmall: TextStyle(color: AppColors.primaryText),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appbarCard, 
        elevation: 0,
      ),
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryButton,
        secondary: AppColors.selectedIcon,
        error: AppColors.errorAlternative,
        surface: AppColors.appbarCard,
      ),
      
      cardTheme: CardThemeData(
        color: AppColors.appbarCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton, 
          foregroundColor: AppColors.primaryText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
      
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryButton, 
      ),

      iconTheme: const IconThemeData(
        color: AppColors.primaryText,
      )
    );
  }
}