import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/screens/home_screen.dart';
import 'package:destiny_tracker_progiii/screens/info_screen.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';

Map<String, Widget Function(BuildContext)> getApplicationRoutes() {
  return {
    AppRoutes.home: (BuildContext context) => const HomeScreen(),
    AppRoutes.info: (BuildContext context) => const InfoScreen(),
  };
}