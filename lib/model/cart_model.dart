import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'product.dart';

/// Model of a shopping cart.
///
/// Notifies listeners whenever the contents of the cart
/// are changed. Stores both the products and the number
/// of each product as a map.
class CartModel extends ChangeNotifier {
  final Map<Product, int> _products = {};

  UnmodifiableMapView<Product, int> get products =>
      UnmodifiableMapView(_products);

  void add(Product product) {
    if (_products.containsKey(product)) {
      _increment(product);
    } else {
      _products[product] = 1;
    }
    notifyListeners();
  }

  void remove(Product product) {
    if (_products.containsKey(product)) {
      _decrement(product);
      notifyListeners();
    }
  }

  void _increment(Product key) {
    _products[key] += 1;
  }

  void _decrement(Product key) {
    if (_products[key] == 1) {
      _products.remove(key);
    } else {
      _products[key] -= 1;
    }
  }
}
