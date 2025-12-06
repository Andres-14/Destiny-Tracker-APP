import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/themes/app_theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha de los Desarrolladores'),
      ),
      body: Center(
        child: SingleChildScrollView( 
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                foregroundImage: NetworkImage('https://i.pinimg.com/736x/f9/9d/e7/f99de71a46eb3e07e1d1f43cc5967617.jpg'),
              ),
              const SizedBox(height: 20),
              Text(
                'Andrés Jiménez & Fabrizio Marchioro',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              Text(
                'Programacion III',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              
              const Divider(color: AppTheme.accentSelected),
              
              Text(
                'Sobre DESTINY TRACKER',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 22, color: AppTheme.accentSelected),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'DESTINY TRACKER es una app pensada en mostrar informacion sobre los diversos clanes que pueden encontrarse en el juego.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.lightText),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Proyecto Final - Versión 1.0.0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}