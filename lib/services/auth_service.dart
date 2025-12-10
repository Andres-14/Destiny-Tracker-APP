import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:destiny_tracker_progiii/models/constants.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

  String getAuthorizationUri() {
    return '${BungieApi.authUrl}?client_id=${BungieApi.clientId}&response_type=code&scope=${BungieApi.scope}';
  }

  Future<void> exchangeCodeForTokens(String code) async {
    final response = await http.post(
      Uri.parse(BungieApi.tokenUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-API-Key': BungieApi.apiKey,
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': BungieApi.clientId,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _saveTokens(data);
    } else {
      throw Exception('Failed to exchange code for tokens: ${response.body}');
    }
  }

  Future<void> _saveTokens(Map<String, dynamic> data) async {
    await storage.write(key: 'access_token', value: data['access_token']);
    await storage.write(key: 'refresh_token', value: data['refresh_token']);
    await storage.write(key: 'membership_id', value: data['membership_id'].toString()); 
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String?> getMembershipId() async {
    return await storage.read(key: 'membership_id');
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }
}