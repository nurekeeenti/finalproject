import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/enhanced_trips_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/map_screen.dart';
import '../providers/app_state.dart';
import 'package:travel_app/screens/register_screen.dart';

class AppStateRouterListener extends ChangeNotifier {
  AppStateRouterListener() {
    appState.addListener(notifyListeners);
  }

  final AppState appState = AppState();

  @override
  void dispose() {
    appState.removeListener(notifyListeners);
    super.dispose();
  }
}

final AppStateRouterListener appStateRouterListener = AppStateRouterListener();

GoRouter createAppRouter({
  required VoidCallback onToggleTheme,
  required VoidCallback onChangeColor,
}) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: appStateRouterListener,
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        appBar: AppBar(title: const Text('404')),
        body: const Center(child: Text('Page not found')),
      ),
    ),
    redirect: (context, state) {
      final loggedIn = appStateRouterListener.appState.isLoggedIn;
      final loggingIn = state.uri.path == '/login';
      final registering = state.uri.path == '/register';

      if (!loggedIn && !loggingIn && !registering) return '/login';
      if (loggedIn && (loggingIn || registering)) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(
          onToggleTheme: onToggleTheme,
          onChangeColor: onChangeColor,
        ),
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
      GoRoute(path: '/trips', builder: (context, state) => const EnhancedTripsScreen()),
      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
    ],
  );
}
