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
}
