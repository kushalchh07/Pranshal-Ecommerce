import 'package:http/http.dart' as http;
import 'package:pranshal_ecommerce/core/constants/strings.dart';
import 'dart:convert';

import '../models/home_model.dart';

class ProductRepository {




  // Method to search products
  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/search/products/$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        List<Product> products = [];
        for (var product in data['products']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
