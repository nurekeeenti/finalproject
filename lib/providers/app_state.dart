import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item.dart';
import '../models/place.dart';

class AppState extends ChangeNotifier {
  // ---------- Firebase Auth ----------
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  AppState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // ---------- Cart ----------
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void updateCartItem(CartItem oldItem, CartItem newItem) {
    final index = _cart.indexOf(oldItem);
    if (index != -1) {
      _cart[index] = newItem;
      notifyListeners();
    }
  }

  // ---------- Favorites ----------
  final List<Place> _favoritePlaces = [];

  List<Place> get favoritePlaces => _favoritePlaces;

  void toggleFavorite(Place place) {
    if (_favoritePlaces.contains(place)) {
      _favoritePlaces.remove(place);
    } else {
      _favoritePlaces.add(place);
    }
    notifyListeners();
  }
}
