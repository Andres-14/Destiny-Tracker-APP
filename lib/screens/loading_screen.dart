import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final refreshToken = await _authService.storage.read(key: 'refresh_token');

    if (mounted) {
      if (refreshToken != null) {
        Navigator.of(context).pushReplacementNamed(Routes.inventory);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Verificando sesión...'),
          ],
        ),
      ),
    );
  }
}