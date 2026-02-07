// search_service.dart
import 'package:shopping/models/product.dart';

class SearchService {
  static List<Product> search(String query, List<Product> allProducts) {
    if (query.isEmpty) {
      return []; // Return empty list if search is empty
    }

    List<Product> results = [];

    for (Product product in allProducts) {
      // Check if product name contains search query (case-insensitive)
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(product);
      }
    }

    return results;
  }
}
