import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/strings.dart';
import '../models/cart_model.dart';

class CartRepository {
  

  // Add product to cart
  Future<void> addToCart(CartItem cartItem) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/carts/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cartItem.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add product to cart");
    }
  }

  // Fetch all cart items
  Future<List<CartItem>> getCartItems(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/api/carts$userId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['cart_items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to fetch cart items");
    }
  }
}
