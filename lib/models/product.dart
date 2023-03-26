class Product {
  final bool isMark;
  final String name;
  late Status status;
  int count;
  final double price;
  late double revenue;
  late String category;

  Product(
      {this.count = 0,
      required this.isMark,
      required this.name,
      required this.price,
      double? revenue})
      : revenue = revenue ?? count * price {
    category = 'Вода';
    status = count == 0
        ? Status.no
        : count < 40
            ? Status.need
            : Status.enough;
  }
}

enum Status { no, enough, need }
