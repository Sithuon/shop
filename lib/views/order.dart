enum OrderStatus { pending, all, completed, cancelled }

class Order {
  final String OrderNumber;
  final double totalAmount;
  final int itemCount;
  final OrderStatus status;
  final DateTime orderDate;
  final String imageUrl;

  Order({
    required this.OrderNumber,
    required this.totalAmount,
    required this.itemCount,
    required this.status,
    required this.orderDate,
    required this.imageUrl,
  });
  String get statusString => status.name;
}
