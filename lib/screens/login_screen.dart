import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _launchBungieAuth(BuildContext context) async {
    final authService = AuthService();
    final url = authService.getAuthorizationUri();
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el navegador para autenticación.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destiny Tracker - Login', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline), 
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.info);
            },
            tooltip: 'Acerca de / Desarrolladores',
            ),
          ],
        ),
        
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¡Bienvenido a Destiny Tracker Inventory!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  icon: const Icon(Icons.security),
                  label: const Text('Iniciar Sesión con Bungie'),
                  onPressed: () => _launchBungieAuth(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}