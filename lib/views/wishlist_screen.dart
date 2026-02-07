import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/controllers/cart_controller.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/cart_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "My Wishlist",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get only favorite products
    final favoriteProducts = products.where((p) => p.isFavorite).toList();

    if (favoriteProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              "Your wishlist is empty",
              style: AppTextStyle.withColor(AppTextStyle.h3, Colors.grey[600]!),
            ),
            SizedBox(height: 8),
            Text(
              "Add products to your wishlist",
              style: AppTextStyle.withColor(
                AppTextStyle.labelMedium,
                Colors.grey[500]!,
              ),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildSummarySection(favoriteProducts.length),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildWishlistItem(favoriteProducts[index]),
              childCount: favoriteProducts.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(int itemCount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$itemCount items",
                style: AppTextStyle.withColor(
                  AppTextStyle.h3,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                " in your wishlist",
                style: AppTextStyle.withColor(
                  AppTextStyle.buttonmedium,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Add all wishlist items to cart
              final favoriteProducts = products
                  .where((p) => p.isFavorite)
                  .toList();
              for (var product in favoriteProducts) {
                cartController.addToCart(product);
              }

              // Show success message
              Get.snackbar(
                "Success",
                "Added all items to cart",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Theme.of(context).primaryColor,
                colorText: Colors.white,
              );

              // Navigate to cart screen
              Get.to(() => CartScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              "Add All to Cart",
              style: AppTextStyle.withColor(
                AppTextStyle.buttonmedium,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(Product product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey[300]!,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildProductImage(product.imageUrl),
            ),
          ),
          const SizedBox(width: 16),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyle.withColor(
                    AppTextStyle.withWeight(AppTextStyle.h3, FontWeight.bold),
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: AppTextStyle.withColor(
                    AppTextStyle.buttonmedium,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (product.oldPrice > product.price)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "\$${product.oldPrice.toStringAsFixed(2)}",
                          style: AppTextStyle.withColor(
                            AppTextStyle.buttonmedium,
                            Colors.grey,
                          ).copyWith(decoration: TextDecoration.lineThrough),
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
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: AppTextStyle.withColor(
                    AppTextStyle.h3,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Action Buttons
          Column(
            children: [
              IconButton(
                onPressed: () {
                  // Add single item to cart
                  cartController.addToCart(product);

                  // Show success message
                  Get.snackbar(
                    "Added to Cart",
                    "${product.name} has been added to your cart",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Theme.of(context).primaryColor,
                    colorText: Colors.white,
                  );
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                tooltip: "Add to Cart",
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () {
                  // Remove from wishlist
                  product.toggleFavorite();

                  // Force UI refresh
                  setState(() {});

                  // Show removal message
                  Get.snackbar(
                    "Removed",
                    "${product.name} removed from wishlist",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
                icon: Icon(Icons.delete_outline, color: Colors.red),
                tooltip: "Remove from Wishlist",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    // Fix the image path
    String assetPath = imageUrl;

    // If it starts with '/', add 'assets' before it
    if (assetPath.startsWith('/')) {
      assetPath = 'assets$assetPath';
    }
    // If it doesn't start with 'assets/', add it
    else if (!assetPath.startsWith('assets/')) {
      assetPath = 'assets/$assetPath';
    }

    // Clean up any double slashes
    assetPath = assetPath.replaceAll('//', '/');

    return Image.asset(
      assetPath,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
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
}
