import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _usernameKey = 'username';
  static const String _cartKey = 'cart_items';

  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }

  Future<List<int>> getCartIds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartStrings = prefs.getStringList(_cartKey);
    if (cartStrings == null) return [];
    return cartStrings.map((e) => int.parse(e)).toList();
  }

  Future<void> addToCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartIds = await getCartIds();
    if (!cartIds.contains(productId)) {
      cartIds.add(productId);
      await prefs.setStringList(_cartKey, cartIds.map((e) => e.toString()).toList());
    }
  }

  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartIds = await getCartIds();
    if (cartIds.contains(productId)) {
      cartIds.remove(productId);
      await prefs.setStringList(_cartKey, cartIds.map((e) => e.toString()).toList());
    }
  }

  Future<bool> isInCart(int productId) async {
    final cartIds = await getCartIds();
    return cartIds.contains(productId);
  }
}
