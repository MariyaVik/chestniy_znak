import 'package:flutter/material.dart';

import '../models/order.dart';

class DataOrders extends ChangeNotifier {
  List<Order> orders = [
    Order(
        agent: 'ООО Вкус', date: DateTime.now(), doc: 'Документ', price: 23000)
  ];

  void add(Order order) {
    orders.add(order);
    notifyListeners();
  }
}
