import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

import 'package:shopping/controllers/navigation_controller.dart';
import 'package:shopping/controllers/theme_controller.dart';
import 'package:shopping/views/account_screen.dart';
import 'package:shopping/views/custome_bottom_navbar.dart';
import 'package:shopping/views/home_screen.dart';
import 'package:shopping/views/shopping_screen.dart';
import 'package:shopping/views/wishlist_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: [
                // Your different screens go here
                HomeScreen(),
                ShoppingScreen(),
                WishListScreen(),
                AccountScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomeBottomNavBar(),
      ),
    );
  }
}
