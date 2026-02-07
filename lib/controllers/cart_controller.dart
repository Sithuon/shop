import 'package:get/get.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/models/cart_item.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <CartItem>[].obs;

  // Get total number of items in cart
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Get subtotal price
  double get subtotal =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Calculate tax (example: 10%)
  double get tax => subtotal * 0.10;

  // Calculate shipping (example: $5.00)
  double get shipping => 5.00;

  // Get total price
  double get total => subtotal + tax + shipping;

  // Add item to cart
  void addToCart(Product product, {int quantity = 1}) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product.name == product.name,
    );

    if (existingItemIndex != -1) {
      // Update quantity if item already exists
      cartItems[existingItemIndex].quantity += quantity;
      cartItems.refresh();
    } else {
      // Add new item
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  // Remove item from cart
  void removeFromCart(String productName) {
    cartItems.removeWhere((item) => item.product.name == productName);
  }

  // Update quantity of an item
  void updateQuantity(String productName, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productName);
      return;
    }

    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product.name == productName,
    );

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity = newQuantity;
      cartItems.refresh();
    }
  }

  // Increase quantity by 1
  void increaseQuantity(String productName) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product.name == productName,
    );

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity++;
      cartItems.refresh();
    }
  }

  // Decrease quantity by 1
  void decreaseQuantity(String productName) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product.name == productName,
    );

    if (existingItemIndex != -1) {
      if (cartItems[existingItemIndex].quantity > 1) {
        cartItems[existingItemIndex].quantity--;
      } else {
        removeFromCart(productName);
      }
      cartItems.refresh();
    }
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }

  // Check if product is in cart
  bool isInCart(Product product) {
    return cartItems.any((item) => item.product.name == product.name);
  }

  // Get quantity of a specific product
  int getProductQuantity(Product product) {
    final item = cartItems.firstWhereOrNull(
      (item) => item.product.name == product.name,
    );
    return item?.quantity ?? 0;
  }
}
