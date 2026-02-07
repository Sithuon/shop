import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/controllers/cart_controller.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/utils/app_textstyle.dart';

import 'package:shopping/views/checkout_sreen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Obx(
          () => Text(
            "My Cart (${cartController.itemCount} items)",
            style: AppTextStyle.withColor(
              AppTextStyle.h3,
              isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Obx(() {
        final cartItems = cartController.cartItems;
        final hasItems = cartItems.isNotEmpty;

        return Column(
          children: [
            Expanded(
              child: hasItems
                  ? ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) =>
                          _buildCartItem(context, cartItems[index]),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Your cart is empty",
                            style: AppTextStyle.withColor(
                              AppTextStyle.h3,
                              Colors.grey[600]!,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add items to get started",
                            style: AppTextStyle.withColor(
                              AppTextStyle.labelMedium,
                              Colors.grey[500]!,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            // Summary and checkout button
            if (hasItems) _buildCheckoutSection(context),
          ],
        );
      }),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = cartItem.product;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey[300]!,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image - SIMPLIFIED VERSION
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: _buildProductImage(product.imageUrl),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: AppTextStyle.withColor(
                            AppTextStyle.h3,
                            isDark ? Colors.white : Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartController.removeFromCart(product.name);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: isDark ? Colors.red : Colors.red[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonsmall,
                      isDark ? Colors.white70 : Colors.grey[700]!,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.oldPrice > product.price)
                            Text(
                              '\$${product.oldPrice.toStringAsFixed(2)}',
                              style:
                                  AppTextStyle.withColor(
                                    AppTextStyle.buttonsmall,
                                    Colors.grey,
                                  ).copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                          Text(
                            '\$${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                            style: AppTextStyle.withColor(
                              AppTextStyle.buttonlarge,
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      // Quantity controls
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartController.decreaseQuantity(product.name);
                              },
                              icon: Icon(Icons.remove, size: 18),
                              padding: EdgeInsets.all(4),
                            ),
                            SizedBox(width: 4),
                            // Use GetX instead of Obx here
                            GetX<CartController>(
                              builder: (controller) {
                                final item = controller.cartItems
                                    .firstWhereOrNull(
                                      (item) =>
                                          item.product.name == product.name,
                                    );
                                return Text(
                                  '${item?.quantity ?? cartItem.quantity}',
                                  style: AppTextStyle.withColor(
                                    AppTextStyle.buttonmedium,
                                    isDark ? Colors.white : Colors.black,
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 4),
                            IconButton(
                              onPressed: () {
                                cartController.increaseQuantity(product.name);
                              },
                              icon: Icon(Icons.add, size: 18),
                              padding: EdgeInsets.all(4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SIMPLE image builder - no complex logic
  Widget _buildProductImage(String imageUrl) {
    // Fix the image path
    String assetPath = imageUrl;

    // If it starts with '/', add 'assets' before it
    if (assetPath.startsWith('/')) {
      assetPath = 'assets$assetPath';
    }

    // Clean up any double slashes
    assetPath = assetPath.replaceAll('//', '/');

    // Print for debugging
    print('🔍 Loading image: $assetPath');

    return Image.asset(
      assetPath,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('❌ Error loading image: $error');
        return Container(
          width: 100,
          height: 100,
          color: Colors.grey[200],
          child: Center(
            child: Icon(Icons.shopping_bag, color: Colors.grey[500], size: 40),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          ),
        ),
      ),
      child: GetX<CartController>(
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white70 : Colors.black,
                    ),
                  ),
                  Text(
                    '\$${controller.subtotal.toStringAsFixed(2)}',
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax",
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white70 : Colors.black,
                    ),
                  ),
                  Text(
                    '\$${controller.tax.toStringAsFixed(2)}',
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping",
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white70 : Colors.black,
                    ),
                  ),
                  Text(
                    '\$${controller.shipping.toStringAsFixed(2)}',
                    style: AppTextStyle.withColor(
                      AppTextStyle.labelMedium,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(color: isDark ? Colors.grey[700] : Colors.grey[300]),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: AppTextStyle.withColor(
                      AppTextStyle.h3,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '\$${controller.total.toStringAsFixed(2)}',
                    style: AppTextStyle.withColor(
                      AppTextStyle.h3,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => CheckoutScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Checkout",
                  style: AppTextStyle.withColor(
                    AppTextStyle.buttonlarge,
                    Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
