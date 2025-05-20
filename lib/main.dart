import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/destination_detail.dart';
import 'models/place.dart';
import 'providers/app_state.dart';
import 'package:travel_app/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'router/app_router.dart';
import 'screens/cart_screen.dart';
import 'screens/enhanced_trips_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/map_screen.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/register_screen.dart';
import 'router/app_router.dart';
import 'package:travel_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const TravelApp(),
    ),
  );
}

class TravelApp extends StatefulWidget {
  const TravelApp({super.key});

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  ThemeMode _themeMode = ThemeMode.light;
  MaterialColor _primarySwatch = Colors.purple;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeColor() {
    setState(() {
      _primarySwatch = _primarySwatch == Colors.purple ? Colors.orange : Colors.purple;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: _primarySwatch,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: _primarySwatch,
        brightness: Brightness.dark,
        cardColor: Colors.grey[800],
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primarySwatch,
          brightness: Brightness.dark,
          surfaceVariant: Colors.grey[850]!,
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: createAppRouter(
        onToggleTheme: _toggleTheme,
        onChangeColor: _changeColor,
      ),
    );

  }

}


