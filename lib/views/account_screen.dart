import 'package:flutter/material.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/my_order_screen.dart';
import 'package:shopping/views/sign_up_screen.dart';
import 'package:shopping/views/signin_screen.dart';
import 'package:shopping/views/wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Screen",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implement logout functionality
            },
            icon: Icon(
              Icons.settings_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(context),
            const SizedBox(height: 24),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("/profile.webp"),
          ),
          SizedBox(height: 16),
          Text(
            "John Doe",
            style: AppTextStyle.withColor(
              AppTextStyle.h2,
              Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "john.doe@example.com",
            style: AppTextStyle.withColor(
              AppTextStyle.h3,
              isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Edit Profile Button
          ElevatedButton(
            onPressed: () {
              // Implement edit profile functionality

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(150, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Edit Profile",
              style: AppTextStyle.withColor(
                AppTextStyle.buttonlarge,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuItem = [
      {"icon": Icons.shopping_bag, "title": "My Orders"},
      {"icon": Icons.favorite, "title": "Wishlist"},
      {"icon": Icons.settings, "title": "logout"},
      {"icon": Icons.help_outline, "title": "Help & Support"},
      {"icon": Icons.info_outline, "title": "About Us"},
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          ...menuItem.map(
            (item) => Column(
              children: [
                ListTile(
                  leading: Icon(
                    item["icon"] as IconData,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    item["title"] as String,
                    style: AppTextStyle.withColor(
                      AppTextStyle.h3,
                      isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  // onTap functionality can be added here
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: isDark ? Colors.white : Colors.black,
                    size: 16,
                  ),

                  onTap: () {
                    if (item["title"] == "My Orders") {
                      // Navigate to My Orders Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrderScreen(),
                        ),
                      );
                    } else if (item["title"] == "Wishlist") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishListScreen(),
                        ),
                      );
                      // Navigate to Wishlist Screen
                    } else if (item["title"] == "logout") {
                      // Logout functionality
                      _showLogoutDialog(context);
                    } else if (item["title"] == "Help & Support") {
                      _showAboutUsDialog(context);
                      // Navigate to Help & Support Screen
                    } else if (item["title"] == "About Us") {
                      _showAboutUsDialog(context);
                      // Navigate to About Us Screen
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? Colors.grey[800] : Colors.white,
        title: Text(
          "Logout",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: AppTextStyle.withColor(
            AppTextStyle.buttonmedium,
            isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: AppTextStyle.withColor(
                AppTextStyle.buttonlarge,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement logout functionality
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              );
            },
            child: Text(
              "Logout",
              style: AppTextStyle.withColor(
                AppTextStyle.buttonlarge,
                Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // About Us Dialog but describe still developing
  void _showAboutUsDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? Colors.grey[800] : Colors.white,
        title: Text(
          "About Us",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          "This feature is still under development. Stay tuned for updates!",
          style: AppTextStyle.withColor(
            AppTextStyle.buttonmedium,
            isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: AppTextStyle.withColor(
                AppTextStyle.buttonlarge,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
