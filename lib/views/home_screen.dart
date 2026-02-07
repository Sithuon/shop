import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/controllers/theme_controller.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/all_product_screen.dart';
import 'package:shopping/views/cart_screen.dart';
import 'package:shopping/views/category_chips.dart';

import 'package:shopping/views/product_detail_screen.dart';
import 'package:shopping/views/product_grid.dart';
import 'package:shopping/views/sale_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Guest";
  String greeting = "Good Morning";
  bool isSearching = false;

  TextEditingController controllerSearch = TextEditingController();
  List<Product> product_search = products;
  List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    _setGreeting();
    _getUserNameFromArguments();

    searchResults.clear();

    controllerSearch.addListener(() {
      if (controllerSearch.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchResults.clear();
        });
      } else {
        setState(() {
          isSearching = true;
        });
      }
    });
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        searchResults.clear();
      });
      return;
    }

    setState(() {
      isSearching = true;
      searchResults = products.where((product) {
        final productName = product.name.toLowerCase();
        final searchInput = query.toLowerCase();
        return productName.contains(searchInput);
      }).toList();
    });
  }

  // Get user name from GetX arguments
  void _getUserNameFromArguments() {
    final arguments = Get.arguments;

    if (arguments != null && arguments['userName'] != null) {
      setState(() {
        userName = arguments['userName'];
      });
    }
  }

  // Set greeting based on time of day
  void _setGreeting() {
    final hour = DateTime.now().hour;

    setState(() {
      if (hour < 12) {
        greeting = "Good Morning";
      } else if (hour < 17) {
        greeting = "Good Afternoon";
      } else {
        greeting = "Good Evening";
      }
    });
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : "G",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    Text(
                      greeting,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.to(() => CartScreen()),
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                GetBuilder<ThemeController>(
                  builder: (themeController) => IconButton(
                    onPressed: () => themeController.switchTheme(),
                    icon: Icon(
                      themeController.isDarkMode
                          ? Icons.wb_sunny_outlined
                          : Icons.nightlight_round_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: controllerSearch,
              onChanged: searchProduct,
              style: AppTextStyle.withColor(
                AppTextStyle.buttonmedium,
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: AppTextStyle.withColor(
                  AppTextStyle.buttonmedium,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                suffixIcon: isSearching
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controllerSearch.clear();
                          setState(() {
                            isSearching = false;
                            searchResults.clear();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          if (isSearching)
            Expanded(
              child: searchResults.isEmpty && controllerSearch.text.isNotEmpty
                  ? Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final product = searchResults[index];
                        return ListTile(
                          leading: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(product.name),
                          onTap: () => Get.to(
                            () => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  const CategoryChips(),
                  const SaleBanner(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AllProductsScreen());
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: ProductGrid()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
