import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;
  const OrderConfirmationScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              SizedBox(height: 24),
              Text(
                "Thank you for your order!",
                style: AppTextStyle.withColor(
                  AppTextStyle.h2,
                  isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Your order number is $orderNumber",
                style: AppTextStyle.withColor(
                  AppTextStyle.h3,
                  isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Total Amount: \$${totalAmount.toStringAsFixed(2)}",
                style: AppTextStyle.withColor(
                  AppTextStyle.h3,
                  isDark ? Colors.white : Colors.black,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: Icon(Icons.home),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                label: Text(
                  "Continue Shopping",
                  style: AppTextStyle.withColor(AppTextStyle.h3, Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
