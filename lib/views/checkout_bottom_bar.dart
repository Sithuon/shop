import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double totalAmount;
  final VoidCallback onPlaceOrder;
  const CheckoutBottomBar({
    super.key,
    required this.totalAmount,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$${totalAmount.toStringAsFixed(2)}",
              style: AppTextStyle.withColor(
                AppTextStyle.h2,
                Theme.of(context).primaryColor,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: onPlaceOrder,
              child: Text(
                "Place Order",
                style: AppTextStyle.withColor(AppTextStyle.h3, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
