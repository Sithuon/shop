import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/all_product_screen.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Big Sale!',
                  style: AppTextStyle.withColor(AppTextStyle.h3, Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  '50% off on selected items. Don\'t miss out!',
                  style: AppTextStyle.withColor(
                    AppTextStyle.withWeight(AppTextStyle.h2, FontWeight.bold),
                    Colors.white70,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Specal offer for you",
                  style: AppTextStyle.withColor(
                    AppTextStyle.buttonmedium,
                    Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.local_offer, color: Colors.white, size: 48),
          ElevatedButton(
            onPressed: () {
              // navigator
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllProductsScreen()),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text(
              'Shop Now',
              style: AppTextStyle.withColor(
                AppTextStyle.buttonmedium,
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
