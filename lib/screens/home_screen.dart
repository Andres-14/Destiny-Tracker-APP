import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';
import 'package:destiny_tracker_progiii/services/bungie_api_service.dart';
import 'package:destiny_tracker_progiii/models/item_models.dart';
import 'package:destiny_tracker_progiii/screens/details_screen.dart';

class _ItemListView extends StatelessWidget {
  final List<DestinyItem> items;

  const _ItemListView({required this.items});

  @override
  Widget build(BuildContext context) {
    final lightText = Theme.of(context).textTheme.bodyMedium?.color;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index]; 
        
        return Card(
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                item.iconPath, 
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.group,
                  size: 30,
                  color: Color(0xFFF2C94C), 
                ),
              ),
            ), 
            title: Text(item.name, style: TextStyle(color: lightText, fontWeight: FontWeight.bold)),
            subtitle: Text(
              item.description.length > 50 
                ? '${item.description.substring(0, 50)}...' 
                : item.description,
              style: TextStyle(color: lightText?.withOpacity(0.7)),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF44AACC)),
            
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(item: item),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destiny Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.info);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<DestinyItem>>(
        future: BungieApiService().fetchClanBanners(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Error al cargar los datos: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFBB3333), fontSize: 16),
                ),
              ),
            );
           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) { 
            return _ItemListView(items: snapshot.data!);
          }
          return const Center(child: Text('No se encontraron clanes en la búsqueda general.'));
        },
      ),
    );
  }
}