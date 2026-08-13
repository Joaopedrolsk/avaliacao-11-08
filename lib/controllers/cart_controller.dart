import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final String size;
  int quantity;

  CartItem({required this.product, required this.size, required this.quantity});
}

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Product product, String size, int quantity) {
    if (quantity <= 0) return;
    final existing = _items.indexWhere(
      (it) => it.product.name == product.name && it.size == size,
    );
    if (existing >= 0) {
      _items[existing].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, size: size, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
