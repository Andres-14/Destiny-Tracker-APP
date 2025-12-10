class BungieApi {
  static const String apiKey = 'ffe8f8e32b194e388c3c521bdeedf644'; 
  
  static const String clientId = '51155'; 
  
  static const String redirectUri = 'bungieinventoryapp://oauth2redirect';

  static const String authUrl = 'https://www.bungie.net/en/OAuth/Authorize';
  static const String tokenUrl = 'https://www.bungie.net/Platform/App/OAuth/token/';
  static const String baseUrl = 'https://www.bungie.net/Platform';

  static const String scope = 'read:Profile D2Inventory';
  
  static const String inventoryComponents = '100,102,200,201,205,300';
}