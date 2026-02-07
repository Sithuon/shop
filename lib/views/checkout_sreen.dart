import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/controllers/cart_controller.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/custom_textfield.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final CartController cartController = Get.find<CartController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

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
        title: Text(
          "Checkout",
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Shipping Information
            Text(
              "Shipping Information",
              style: AppTextStyle.withColor(
                AppTextStyle.h3,
                isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            CustomTextfield(
              label: "Full Name",
              prefixIcon: Icons.person,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            CustomTextfield(
              label: "Email",
              prefixIcon: Icons.email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            CustomTextfield(
              label: "Address",
              prefixIcon: Icons.home,
              controller: _addressController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    label: "City",
                    prefixIcon: Icons.location_city,
                    controller: _cityController,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomTextfield(
                    label: "ZIP Code",
                    prefixIcon: Icons.map,
                    controller: _zipController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Payment Information
            Text(
              "Payment Information",
              style: AppTextStyle.withColor(
                AppTextStyle.h3,
                isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            CustomTextfield(
              label: "Card Number",
              prefixIcon: Icons.credit_card,
              controller: _cardController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter card number';
                }
                if (value.length < 16) {
                  return 'Please enter a valid card number';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    label: "Expiry (MM/YY)",
                    prefixIcon: Icons.calendar_today,
                    controller: _expiryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomTextfield(
                    label: "CVV",
                    prefixIcon: Icons.lock,
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (value.length < 3) {
                        return 'Invalid CVV';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Order Summary
            Text(
              "Order Summary",
              style: AppTextStyle.withColor(
                AppTextStyle.h3,
                isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Items (${cartController.itemCount})",
                          style: AppTextStyle.withColor(
                            AppTextStyle.labelMedium,
                            isDark ? Colors.white70 : Colors.black,
                          ),
                        ),
                        Text(
                          '\$${cartController.subtotal.toStringAsFixed(2)}',
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
                          '\$${cartController.tax.toStringAsFixed(2)}',
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
                          '\$${cartController.shipping.toStringAsFixed(2)}',
                          style: AppTextStyle.withColor(
                            AppTextStyle.labelMedium,
                            isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                    ),
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
                          '\$${cartController.total.toStringAsFixed(2)}',
                          style: AppTextStyle.withColor(
                            AppTextStyle.h3,
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Place Order Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Show success dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Order Placed!"),
                      content: Text("Your order has been placed successfully."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cartController.clearCart();
                            Get.back(); // Close dialog
                            Get.back(); // Go back to cart
                            Get.back(); // Go back to previous screen
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Place Order",
                style: AppTextStyle.withColor(
                  AppTextStyle.buttonlarge,
                  Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
