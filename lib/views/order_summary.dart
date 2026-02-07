import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(context, "Subtotal", "\$100.00"),
          _buildSummaryRow(context, "Shipping", "\$5.00"),
          _buildSummaryRow(context, "Tax", "\$5.00"),
          Divider(),
          _buildSummaryRow(context, "Total", "\$105.00", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.withColor(
              isTotal ? AppTextStyle.h3 : AppTextStyle.h3,
              isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.withColor(
              isTotal ? AppTextStyle.h3 : AppTextStyle.h3,
              Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
