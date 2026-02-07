import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/order.dart';

class OrderCard extends StatelessWidget {
  final VoidCallback onViewDetails;
  final Order order;

  const OrderCard({
    required this.onViewDetails,
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(order.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.OrderNumber,
                        style: AppTextStyle.withColor(
                          AppTextStyle.h3,
                          isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        "Status: ${order.statusString}",
                        style: AppTextStyle.withColor(
                          AppTextStyle.h3,
                          isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order.itemCount} items - \$${order.totalAmount.toStringAsFixed(2)}',
                        style: AppTextStyle.withColor(
                          AppTextStyle.h3,
                          isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildStatusChips(context, order.statusString),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChips(BuildContext context, String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "pending":
        bgColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case "completed":
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case "cancelled":
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTextStyle.withColor(AppTextStyle.h3, textColor),
      ),
    );
  }
}
