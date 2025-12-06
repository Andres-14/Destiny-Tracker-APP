import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';
import 'package:destiny_tracker_progiii/themes/app_theme.dart';
import 'package:destiny_tracker_progiii/models/menu_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destiny Tracker',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: getApplicationRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}