import 'package:flutter/material.dart';

import '../models/supply.dart';

class DataSupplies extends ChangeNotifier {
  List<Supply> supplies = [
    Supply(
        agent: 'ООО ПромТогр',
        count: 250,
        date: DateTime.now(),
        deliveryPrice: 3000,
        name: 'Молоко',
        purchasePrice: 10000),
    Supply(
        agent: 'ООО ПромТогр',
        count: 20,
        date: DateTime.now(),
        deliveryPrice: 1500,
        name: 'Творог',
        purchasePrice: 7000),
  ];

  Supply? currentSupply;

  void add(Supply supply) {
    supplies.add(supply);
    notifyListeners();
  }

  void qrData() {
    currentSupply = Supply(
        agent: 'ООО QR',
        count: 333,
        date: DateTime.now(),
        deliveryPrice: 0,
        name: 'Молоко',
        purchasePrice: 0);
    notifyListeners();
  }
}
