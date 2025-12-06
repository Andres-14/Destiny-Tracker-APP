import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/models/item_models.dart';

class DetailsScreen extends StatelessWidget {
  final DestinyItem item; 

  const DetailsScreen({
    super.key,
    required this.item, 
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: theme.appBarTheme.backgroundColor, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  item.iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.group, 
                    size: 120, 
                    color: Color(0xFFF2C94C), 
                  ), 
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              item.name,
              style: textTheme.headlineLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Color(0xFF44AACC)),

            Text(
              'Lema / Descripción del Clan',
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              item.description,
              style: textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}