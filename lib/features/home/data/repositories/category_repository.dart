import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/constants/strings.dart';
import '../models/home_model.dart';

class CategoryRepository {
  // Method to search categories
  Future<List<Category>> searchCategories(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/search/categories/$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        List<Category> categories = [];
        for (var category in data['categories']) {
          categories.add(Category.fromJson(category));
        }
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

   Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final url = Uri.parse('$baseUrl/api/products/category/$categoryId');
    log('Fetching products for categoryId: $categoryId from $url');

    try {
      final response = await http.get(url);
      log('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status']) {
          log('Successfully fetched products for categoryId: $categoryId');

          // ✅ Convert List of Maps to List of Product objects
          List<Product> products = (data['products'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();

          return products;
        } else {
          log('Failed to fetch products for categoryId: $categoryId - Status false');
          throw Exception("Failed to fetch products");
        }
      } else {
        log('Error: ${response.statusCode} while fetching products for categoryId: $categoryId');
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      log('Error fetching products for categoryId: $categoryId - $e');
      throw Exception("Error fetching products: $e");
    }
  }
}
