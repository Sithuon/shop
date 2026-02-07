import 'package:shopping/views/order.dart';

class OrderRepository {
  List<Order> getOrders() {
    return [
      Order(
        OrderNumber: "ORD123456",
        totalAmount: 120.0,
        itemCount: 3,
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        imageUrl: "/adidas_blue.webp",
      ),
      Order(
        OrderNumber: "ORD123457",
        totalAmount: 80.0,
        itemCount: 2,
        status: OrderStatus.completed,
        orderDate: DateTime.now().subtract(Duration(days: 1)),
        imageUrl: "/adidas.webp",
      ),
      Order(
        OrderNumber: "ORD123458",
        totalAmount: 150.0,
        itemCount: 5,
        status: OrderStatus.pending,
        orderDate: DateTime.now().subtract(Duration(days: 2)),
        imageUrl: "/nike_blue.webp",
      ),
      Order(
        OrderNumber: "ORD123459",
        totalAmount: 200.0,
        itemCount: 4,
        status: OrderStatus.completed,
        orderDate: DateTime.now().subtract(Duration(days: 3)),
        imageUrl: "/nike_green.webp",
      ),
      Order(
        OrderNumber: "ORD123460",
        totalAmount: 50.0,
        itemCount: 1,
        status: OrderStatus.cancelled,
        orderDate: DateTime.now().subtract(Duration(days: 4)),
        imageUrl: "/nike_pink.webp",
      ),
      Order(
        OrderNumber: "ORD123461",
        totalAmount: 90.0,
        itemCount: 2,
        status: OrderStatus.pending,
        orderDate: DateTime.now().subtract(Duration(days: 5)),
        imageUrl: "/nike_sport_shoes.webp",
      ),
    ];
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return getOrders().where((order) => order.status == status).toList();
  }
}
