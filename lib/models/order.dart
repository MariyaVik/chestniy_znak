import 'dart:math';

class Order {
  final int id;
  final DateTime date;

  final String agent;
  final int price;
  final String doc;
  Order(
      {int? id,
      required this.agent,
      required this.date,
      required this.doc,
      required this.price})
      : id = id ?? Random().nextInt(666);
}
