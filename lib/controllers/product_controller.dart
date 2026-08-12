import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductController extends ChangeNotifier {
  late String _selectedSize;
  int _quantity = 0;
  bool _isFavorite = false;

  final Product product;

  ProductController({required this.product}) {
    _selectedSize = product.availableSizes.isNotEmpty
        ? product.availableSizes.first
        : 'M';
  }

  String get selectedSize => _selectedSize;

  int get quantity => _quantity;

  bool get isFavorite => _isFavorite;

  void selectSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  double getSubtotal() {
    return product.price * _quantity;
  }
}
