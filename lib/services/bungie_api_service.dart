import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/models/constants.dart';

class ApiService {
  late final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final accessToken = await _authService.getAccessToken();

    if (accessToken == null) {
      throw Exception('No Access Token available. User must log in.');
    }
    
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
      throw Exception('HTTP Request Failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getDestinyMembershipInfo() async {
    final uri = Uri.https(
      'www.bungie.net', 
      '/Platform/User/GetMembershipsForCurrentUser/'
    );
    
    final responseMap = await _get(uri); 

    if (responseMap.containsKey('destinyMemberships') && responseMap['destinyMemberships'] != null) {
        List<dynamic> memberships = responseMap['destinyMemberships'];
        
        if (memberships.isNotEmpty) {
          return memberships.first; 
        } else {
          throw Exception('No Destiny memberships found for this user.');
        }
    } else {
        throw Exception('API Response did not contain destinyMemberships data.');
    }
  }

  Future<Map<String, dynamic>> getDestinyProfile() async {
    final destinyMembershipId = await _authService.getMembershipId();
    final membershipTypeString = await _authService.getMembershipType();

    if (destinyMembershipId == null || membershipTypeString == null) {
      throw Exception('Destiny Membership ID or Type not found.');
    }
    
    final uri = Uri.https(
      'www.bungie.net', 
      '/Platform/Destiny2/$membershipTypeString/Profile/$destinyMembershipId/', 
      {
        'components': BungieApi.inventoryComponents 
      }
    );
    
    return await _get(uri); 
  }

  Future<Map<String, dynamic>> getCharacterInventory(String characterId, String membershipType, String membershipId) async {
    final uri = Uri.https(
      'www.bungie.net',
      '/Platform/Destiny2/$membershipType/Profile/$membershipId/Character/$characterId/',
      {
        'components': '201,300'
      }
    );

    return await _get(uri);
  }
}