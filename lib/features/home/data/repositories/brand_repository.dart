import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/constants/strings.dart';
import '../models/home_model.dart';

class BrandRepository {
  // Method to search brands
  Future<List<Brand>> searchBrands(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/search/brands/$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        List<Brand> brands = [];
        for (var brand in data['brands']) {
          brands.add(Brand.fromJson(brand));
        }
        return brands;
      } else {
        throw Exception('Failed to load brands');
      }
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<List<Product>> fetchProductsByBrand(int brandId) async {
    final url = Uri.parse('$baseUrl/api/products/brand/$brandId');
    log('Fetching products for brandId: $brandId from $url');

    try {
      final response = await http.get(url);
      log('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status']) {
          log('Successfully fetched products for brandId: $brandId');

          // ✅ Convert List of Maps to List of Product objects
          List<Product> products = (data['products'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();

          return products;
        } else {
          log('Failed to fetch products for brandId: $brandId - Status false');
          throw Exception("Failed to fetch products");
        }
      } else {
        log('Error: ${response.statusCode} while fetching products for brandId: $brandId');
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      log('Error fetching products for brandId: $brandId - $e');
      throw Exception("Error fetching products: $e");
    }
  }
}
