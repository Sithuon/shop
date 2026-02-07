import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/utils/app_textstyle.dart';
import 'package:shopping/views/custom_textfield.dart';
import 'package:shopping/views/main_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  // 1️⃣ CONNECT TO FIREBASE DATABASE
  // This line creates a connection to Google's Firebase Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 2️⃣ TEXT CONTROLLERS
  // These store what the user types in each text field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 3️⃣ VALIDATION FUNCTION
  // Checks if all inputs are correct before signing up
  bool _validateInputs() {
    // Check name length (at least 6 characters)
    if (_fullNameController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Name must be at least 6 letters',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Check if email format is valid
    if (!GetUtils.isEmail(_emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Check password length (at least 6 characters)
    if (_passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Check if both passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
      );
      return false;
    }

    return true; // All validations passed
  }

  // 4️⃣ SIGN UP FUNCTION (MAIN FUNCTION)
  Future<void> _signUpUser() async {
    // Step 1: Validate inputs first
    if (!_validateInputs()) {
      return; // Stop if validation fails
    }

    // Step 2: Show loading spinner
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Step 3: Get user input data
      String name = _fullNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Step 4: Check if email already exists in Firebase
      var query = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isNotEmpty) {
        Get.back(); // Close loading
        Get.snackbar(
          'Error',
          'Email already registered',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Step 5: Save user data to Firebase
      await firestore.collection('users').add({
        'name': name,
        'email': email,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(), // Adds current timestamp
      });

      // Step 6: Close loading and show success
      Get.back(); // Close loading
      Get.snackbar(
        'Success!',
        'Account created for $name',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // 🎯 IMPORTANT: Pass user name to HomeScreen
      // This sends the user's name to the next screen
      Get.offAll(
        () => MainScreen(),
        arguments: {'userName': name}, // Pass name as argument
      );
    } catch (error) {
      // Step 7: Handle any errors
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
    // Check if dark mode is enabled
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 5️⃣ BACK BUTTON
              IconButton(
                onPressed: () => Get.back(), // Go back to previous screen
                icon: const Icon(Icons.arrow_back_ios_new),
                color: isDark ? Colors.white : Colors.black,
              ),

              const SizedBox(height: 20),

              // 6️⃣ TITLE
              Text(
                'Create Account',
                style: AppTextStyle.withColor(
                  AppTextStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),

              const SizedBox(height: 8),

              // SUBTITLE
              Text(
                'Sign up to get started!',
                style: AppTextStyle.withColor(
                  AppTextStyle.h2,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),

              const SizedBox(height: 40),

              // 7️⃣ FULL NAME FIELD
              CustomTextfield(
                label: 'Full Name',
                prefixIcon: Icons.person_outline,
                controller: _fullNameController,
              ),

              const SizedBox(height: 16),

              // EMAIL FIELD
              CustomTextfield(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
              ),

              const SizedBox(height: 16),

              // PASSWORD FIELD
              CustomTextfield(
                label: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true, // Hides password with dots
                controller: _passwordController,
              ),

              const SizedBox(height: 16),

              // CONFIRM PASSWORD FIELD
              CustomTextfield(
                label: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _confirmPasswordController,
              ),

              const SizedBox(height: 24),

              // 8️⃣ SIGN UP BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signUpUser, // Calls the sign up function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 9️⃣ ALREADY HAVE ACCOUNT LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonmedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(), // Go to sign in screen
                    child: Text(
                      'Sign In',
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
