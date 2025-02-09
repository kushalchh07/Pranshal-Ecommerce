import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pranshal_ecommerce/core/constants/strings.dart';
import 'dart:convert';

import '../models/home_model.dart';

class ProductRepository {
  // Method to search products
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/products/search/products/$query'),
      );
      log('response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          List<Product> products = [];
          for (var product in data['products']) {
            products.add(Product.fromJson(product));
          }
          return products;
        } else {
          log('Failed to load products');
          throw Exception('Failed to load products');
        }
      } else {
        log('Failed to load products');
        throw Exception('Failed to load products');
      }
    } on Exception catch (e) {
      log('Error while searching products: $e');
      rethrow;
    }
  }
}
