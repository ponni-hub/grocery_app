// cart_provider.dart
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_item.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }
}
