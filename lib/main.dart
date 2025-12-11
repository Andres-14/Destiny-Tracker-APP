import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:destiny_tracker_progiii/routes/app_routes.dart';
import 'package:destiny_tracker_progiii/themes/app_theme.dart';
import 'package:destiny_tracker_progiii/services/auth_service.dart';
import 'package:destiny_tracker_progiii/screens/loading_screen.dart';
import 'package:destiny_tracker_progiii/screens/login_screen.dart';
import 'package:destiny_tracker_progiii/screens/inventory_screen.dart';
import 'package:destiny_tracker_progiii/screens/info_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late final AppLinks _appLinks; 
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks(); 
    _listenForDeepLinks(); 
  }

  void _listenForDeepLinks() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri? uri) {
    if (uri != null && uri.scheme == 'bungieinventoryapp' && uri.host == 'oauth2redirect') {
      final code = uri.queryParameters['code'];
      if (code != null) {
        _authService.exchangeCodeForTokens(code).then((_) {
          navigatorKey.currentState!.pushReplacementNamed(Routes.inventory);
        }).catchError((e) {
          print('Error al intercambiar código: $e');
          navigatorKey.currentState!.pushReplacementNamed(Routes.login);
        });
      }
    } 
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Destiny Inventory Tracker',
      theme: AppTheme.darkTheme,
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (context) => const LoadingScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.inventory: (context) => const InventoryScreen(),
        Routes.info: (context) => const InfoScreen(),
      },
    );
  }
}