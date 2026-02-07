import 'package:flutter/material.dart';

import 'package:shopping/features/order_repository.dart';

import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/order.dart';
import 'package:shopping/views/order_card.dart';

class MyOrderScreen extends StatelessWidget {
  final OrderRepository _orderRepository = OrderRepository();
  MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: AppTextStyle.withColor(
              AppTextStyle.h3,
              isDark ? Colors.white : Colors.black,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, OrderStatus.pending),
            _buildOrderList(context, OrderStatus.completed),
            _buildOrderList(context, OrderStatus.cancelled),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, OrderStatus status) {
    final orders = _orderRepository.getOrdersByStatus(status);
    if (orders.isEmpty) {
      return Center(
        child: Text(
          "No orders found.",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : Colors.black54,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) =>
          OrderCard(order: orders[index], onViewDetails: () {}),
    );
  }
}
