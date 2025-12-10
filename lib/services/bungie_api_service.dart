import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/models/constants.dart';

class ApiService {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> _get(String path) async {
    final accessToken = await _authService.getAccessToken();

    if (accessToken == null) {
      throw Exception('No Access Token available. User must log in.');
    }

    final uri = Uri.parse('${BungieApi.baseUrl}$path');
    final response = await http.get(
      uri,
      headers: {
        'X-API-Key': BungieApi.apiKey,
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['ErrorCode'] == 1) {
        return jsonResponse['Response'];
      } else {
        throw Exception('Bungie API Error (${jsonResponse['ErrorCode']}): ${jsonResponse['Message']}');
      }
    } else {
      throw Exception('HTTP Request Failed: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getDestinyProfile() async {
    const int membershipType = 254; 
    final destinyMembershipId = await _authService.getMembershipId();

    if (destinyMembershipId == null) {
      throw Exception('Destiny Membership ID not found.');
    }
    
    final String components = BungieApi.inventoryComponents; 
    
    final path = '/Destiny2/$membershipType/Profile/$destinyMembershipId/?components=$components';
    
    return await _get(path);
  }
}