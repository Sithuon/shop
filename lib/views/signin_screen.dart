import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/custom_textfield.dart';
import 'package:shopping/views/forget_password_screen.dart';
import 'package:shopping/views/main_screen.dart';
import 'package:shopping/views/sign_up_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  // Connect to Firebase database
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 1. CHECK IF INPUTS ARE VALID
  bool _validateInputs() {
    // Check if email is empty
    if (_emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if email format is correct
    if (!GetUtils.isEmail(_emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if password is empty
    if (_passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // 2. SIGN IN FUNCTION
  Future<void> _signInUser() async {
    // First, check if inputs are valid
    if (!_validateInputs()) {
      return;
    }

    // Show loading spinner
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Get user input
      String email = _emailController.text;
      String password = _passwordController.text;

      // 3. CHECK IN FIREBASE DATABASE
      // Look for user with matching email AND password
      var result = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      // 4. CHECK RESULT
      if (result.docs.isNotEmpty) {
        // User found - sign in successful!
        Get.back(); // Close loading
        Get.snackbar(
          'Success!',
          'Welcome back!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Go to main screen
        Get.offAll(() => MainScreen());
      } else {
        // No user found - sign in failed
        Get.back(); // Close loading
        Get.snackbar(
          'Error',
          'Wrong email or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      // If something goes wrong
      Get.back(); // Close loading
      Get.snackbar(
        'Error',
        'Something went wrong: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // TITLE
              Text(
                'Welcome Back!',
                style: AppTextStyle.withColor(
                  AppTextStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),

              const SizedBox(height: 16),

              // SUBTITLE
              Text(
                'Please sign in to continue shopping.',
                style: AppTextStyle.withColor(
                  AppTextStyle.h2,
                  isDark ? Colors.white70 : Colors.grey[600]!,
                ),
              ),

              const SizedBox(height: 40),

              // EMAIL FIELD
              CustomTextfield(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
              ),

              const SizedBox(height: 20),

              // PASSWORD FIELD
              CustomTextfield(
                label: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 40),

              // FORGET PASSWORD LINK
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => ForgetPasswordScreen()),
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),

              // SIGN IN BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signInUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // SIGN UP LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => SignUpScreen()),
                    child: Text(
                      'Sign Up',
                      style: AppTextStyle.withColor(
                        AppTextStyle.buttonmedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
