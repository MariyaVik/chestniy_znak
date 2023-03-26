class Supply {
  final DateTime date;
  final String name;
  final String agent;
  final int count;
  final double purchasePrice;
  final double deliveryPrice;

  Supply({
    required this.agent,
    required this.count,
    required this.date,
    required this.deliveryPrice,
    required this.name,
    required this.purchasePrice,
  });
}
