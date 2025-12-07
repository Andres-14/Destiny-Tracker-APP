import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:destiny_tracker_progiii/models/item_models.dart';

class BungieApiService {
static const String _apiKey = 'bd7e23db1f044259b28a468bedf04175';
static const String _baseUrl = 'https://www.bungie.net/Platform';
static const String _clanSearchPath = '/GroupV2/Search/';
static const String _bungieImageBaseUrl = 'https://www.bungie.net';

Future<List<DestinyItem>> fetchClanBanners() async {
  final url = Uri.parse('$_baseUrl$_clanSearchPath');

  final Map<String, dynamic> requestBody = {
    'groupType': 1, 
    'currentPage': 1,
    'sortBy': 3,
  };

  final response = await http.post(
    url,
    headers: {
      'X-API-Key': _apiKey,
      'Accept-Language': 'en',
      'Content-Type': 'application/json',
      'User-Agent': 'DestinyTrackerApp/1.0 (Contact: andresjsgs.14@gmail.com)',
    },
     body: json.encode(requestBody),
  );

  if (response.statusCode != 200) {
    throw Exception('Error en la petición API. Código de estado: ${response.statusCode}.');
  }

  final Map<String, dynamic> jsonBody = json.decode(response.body);

  if (jsonBody['ErrorCode'] != 1) {
    throw Exception('Error interno de Bungie. Mensaje: ${jsonBody['Message']}');
  }

  final List<dynamic> results = (jsonBody['Response']?['results'] as List<dynamic>?) ?? [];
  final List<DestinyItem> clanItems = [];

  for (var item in results) {
    if (item is Map<String, dynamic>) {
      final Map<String, dynamic> group = item['group'] ?? {};
      final String name = group['name'] ?? 'Clan Desconocido';
      final String description = group['motto'] ?? 'Sin lema.';
      final String relativeIconPath = group['bannerPath'] ?? '';

      clanItems.add(
        DestinyItem(
          name: name,
          description: description,
          iconPath: relativeIconPath.isNotEmpty
              ? _bungieImageBaseUrl + relativeIconPath
              : '',
        ),
      );
    }
  }

  return clanItems;
}
}
