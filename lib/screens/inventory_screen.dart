import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';
import 'package:destiny_tracker_progiii/services/bungie_api_service.dart';
import 'package:destiny_tracker_progiii/themes/app_theme.dart';
import 'package:destiny_tracker_progiii/screens/character_detail_screen.dart'; 


class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final ApiService _apiService = ApiService();
  late Future<Map<String, dynamic>> _inventoryData;

  @override
  void initState() {
    super.initState();
    _inventoryData = _apiService.getDestinyProfile();
  }
  
  void _logout() async {
    await AuthService().logout();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destiny Tracker - Inventory', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.info);
            },
            tooltip: 'Acerca de / Desarrolladores',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _inventoryData = _apiService.getDestinyProfile();
              });
            },
            tooltip: 'Recargar Inventario',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _inventoryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error: ${snapshot.error}', textAlign: TextAlign.center, style: TextStyle(color: AppColors.errorAlternative)),
              ),
            );
          } else if (snapshot.hasData) {
            
            final characters = snapshot.data!['characters']?['data'] ?? {};
            final vaultItems = snapshot.data!['profileInventories']?['data']?['items'] ?? [];
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Personajes Activos:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  
                  if (characters.isNotEmpty)
                    ...characters.entries.map<Widget>((entry) {
                      final characterId = entry.key;
                      final charData = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.person, color: AppColors.selectedIcon),
                            title: Text('${_getClassTypeName(charData['classType'] ?? -1)}', 
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Luz: ${charData['light'] ?? 0}', 
                                style: const TextStyle(color: AppColors.primaryButton)), 
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // *** Implementación de la navegación al detalle del personaje ***
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CharacterDetailScreen(
                                    characterData: charData,
                                    characterId: characterId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList()
                  else
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text("No se encontraron personajes activos")),
                    ),
                  
                  const Divider(height: 30, color: AppColors.appbarCard),
                  
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Depósito (Vault) - Ítems cargados: ${vaultItems.length}', 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron datos de inventario.'));
          }
        },
      ),
    );
  }

  String _getClassTypeName(int classType) {
    switch (classType) {
      case 0: return 'Titán';
      case 1: return 'Cazador';
      case 2: return 'Hechicero';
      default: return 'Desconocido';
    }
  }
}