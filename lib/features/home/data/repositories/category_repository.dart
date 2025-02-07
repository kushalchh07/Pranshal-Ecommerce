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
}
