import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopping/controllers/cart_controller.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/cart_screen.dart';
import 'package:shopping/views/size_selector.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Details",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          //share button
          IconButton(
            onPressed: () =>
                _shareProduct(context, product.name, product.description),
            icon: Icon(
              Icons.share,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Product Image
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Favorite button
                Positioned(
                  right: 16,
                  top: 16,
                  child: CircleAvatar(
                    backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite
                            ? Theme.of(context).primaryColor
                            : isDark
                            ? Colors.grey[400]
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product Details
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
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
                            AppTextStyle.h2,
                            isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: AppTextStyle.withColor(
                          AppTextStyle.h2,
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.category,
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Selected Size:",
                    style: AppTextStyle.withColor(
                      AppTextStyle.h3,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Size options
                  const SizeSelector(),
                  SizedBox(height: screenHeight * 0.02),
                  // Product Description
                  Text(
                    " Description",
                    style: AppTextStyle.withColor(
                      AppTextStyle.h3,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    product.description,
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonsmall,
                      isDark ? Colors.grey[300]! : Colors.grey[800]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Add to Cart and Buy Now Buttons
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Get cart controller
                    final cartController = Get.find<CartController>();

                    // Add product to cart
                    cartController.addToCart(product);

                    // Show success message
                    Get.snackbar(
                      'Success!',
                      '${product.name} added to cart!',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 2),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Get cart controller
                    final cartController = Get.find<CartController>();

                    // Add product to cart
                    cartController.addToCart(product);

                    // Go to cart screen
                    Get.to(() => CartScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Buy Now",
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to share product details
  Future<void> _shareProduct(
    BuildContext context,
    String productName,
    String description,
  ) async {
    //get the render box for share position(required for share ipad)
    final box = context.findRenderObject() as RenderBox?;
    const String shoplink = "https://www.shoplink.com/product";
    final String shareText =
        "$productName\n\n$description\n\nCheck it out here: $shoplink";
    try {
      final ShareResult result = await Share.share(
        shareText,
        subject: productName,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      if (result.status == ShareResultStatus.success) {
        debugPrint("Product shared successfully");
      } else if (result.status == ShareResultStatus.dismissed) {
        debugPrint("Share dismissed");
      } else {
        debugPrint("Share failed");
      }
    } catch (e) {
      // Handle error if sharing fails
      debugPrint("Error sharing product: $e");
    }
  }
}
// 