import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBackground = Color(0xFF181C22);
  static const Color cardColor = Color(0xFF232830);
  static const Color lightText = Color(0xFFF5F5F5);
  static const Color primaryButton = Color(0xFF44AACC);
  static const Color accentSelected = Color(0xFFF2C94C);
  static const Color errorColor = Color(0xFFBB3333);
  
  static final ThemeData lightTheme = ThemeData(
    primaryColor: cardColor, 
    scaffoldBackgroundColor: darkBackground,
    
    colorScheme: const ColorScheme.dark(
      primary: cardColor,
      secondary: accentSelected, 
      surface: cardColor,
      onPrimary: lightText,
      onSecondary: darkBackground, 
      onSurface: lightText,
      error: errorColor,
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: lightText, fontWeight: FontWeight.bold, fontFamily: 'Titulos'), 
      bodyMedium: TextStyle(color: lightText, fontSize: 16, fontFamily: 'Cuerpo'), 
      bodySmall: TextStyle(color: lightText, fontFamily: 'Cuerpo'),
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: cardColor, 
      foregroundColor: lightText,
      centerTitle: true,
      elevation: 4.0,
    ),
    
    cardTheme: const CardThemeData( 
      color: AppTheme.cardColor, 
      elevation: 6,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: lightText, 
        backgroundColor: primaryButton,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    ),
    
    iconTheme: const IconThemeData(
      color: lightText,
    ),
  );
}