import 'package:flutter/material.dart';
import 'package:destiny_tracker_progiii/services/bungie_api_service.dart';
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/themes/app_theme.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Map<String, dynamic> characterData;
  final String characterId;

  const CharacterDetailScreen({Key? key, required this.characterData, required this.characterId}) : super(key: key);

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final ApiService _apiService = ApiService();
  
  Future<Map<String, dynamic>> _characterInventoryFuture = Future.value({}); 
  
  String? _membershipType;
  String? _membershipId;

  @override
  void initState() {
    super.initState();
    _loadInventoryData();
  }

  void _loadInventoryData() async {
    _membershipType = await AuthService().getMembershipType();
    _membershipId = await AuthService().getMembershipId();

    if (_membershipType != null && _membershipId != null) {
      setState(() {
        _characterInventoryFuture = _apiService.getCharacterInventory(
          widget.characterId,
          _membershipType!,
          _membershipId!,
        );
      });
    } else {
       setState(() {
          _characterInventoryFuture = Future.error("Faltan credenciales de membresía.");
       });
       print("Error: No se encontró ID de membresía para cargar el inventario.");
    }
  }


  @override
  Widget build(BuildContext context) {
    final className = widget.characterData['classType'] == 0 ? 'Titán' : widget.characterData['classType'] == 1 ? 'Cazador' : 'Hechicero';
    final light = widget.characterData['light'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario de $className'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _characterInventoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar inventario: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            
            final items = snapshot.data!['inventory']?['data']?['items'] ?? [];
            
            return Column(
              children: [
                ListTile(title: Text('Luz: $light | Total Ítems: ${items.length}')),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text('Item Hash: ${item['itemHash']}', style: TextStyle(fontWeight: FontWeight.bold, color:AppColors.selectedIcon ),),
                        subtitle: Text(item['bindStatus'] == 1 ? 'Equipado' : 'En bolsillo/Inventario', style: TextStyle(color: AppColors.primaryButton),),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No se encontraron datos de inventario.'));
          }
        },
      ),
    );
  }
}