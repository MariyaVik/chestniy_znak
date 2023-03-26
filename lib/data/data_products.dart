import 'package:flutter/material.dart';

import '../models/product.dart';

class DataProducts extends ChangeNotifier {
  List<Product> products = [
    Product(
        count: 250, price: 3000, name: 'Молоко', revenue: 10000, isMark: true),
    Product(
        count: 20, price: 1500, name: 'Творог', revenue: 7000, isMark: true),
    Product(count: 124, price: 5000, name: 'Сыр', revenue: 10000, isMark: true),
    Product(
        count: 334, price: 1000, name: 'Йогурт', revenue: 15000, isMark: true),
  ];

  Product? currentProduct;

  void add(Product product) {
    products.add(product);
    notifyListeners();
  }

  void qrData() {
    currentProduct =
        Product(count: 0, price: 0, name: 'QR', revenue: 0, isMark: true);
    notifyListeners();
  }
}
