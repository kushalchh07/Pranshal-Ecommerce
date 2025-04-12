import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pranshal_ecommerce/core/constants/strings.dart';
import 'package:http/http.dart' as http;
import '../models/order_cart_model.dart';

class OrderRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> placeSingleOrder(Order order) async {
    try {
      final response =
          await _dio.post('/api/orders/place', data: order.toJson());
      return response.statusCode == 200;
    } catch (e) {
      log("Error placing order: $e");
      return false;
    }
  }

  Future<bool> placeCartOrder(
      int userId, String paymentMethod, String deliveryLocation) async {
    try {
      final response =
          await _dio.post('/api/orders/place-from-cart/$userId', data: {
        "payment_method": paymentMethod,
        "delivery_location": deliveryLocation,
      });
      return response.statusCode == 200;
    } catch (e) {
      log("Error placing cart order: $e");
      return false;
    }
  }


  Future<bool> placeFullCartOrder({
    required int userId,
    required String paymentMethod,
    required String deliveryLocation,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/orders/from-cart/all'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'payment_method': paymentMethod,
        'delivery_location': deliveryLocation,
      }),
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    return response.statusCode == 200;
  }

  Future<bool> placeSelectedCartOrder({
    required int userId,
    required List<int> productIds,
    required String paymentMethod,
    required String deliveryLocation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/orders/from-cart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'product_ids': productIds,
          'payment_method': paymentMethod,
          'delivery_location': deliveryLocation,
        }),
      );

      if (response.statusCode == 200) {
        log("Order placed successfully for user: $userId");
        return true;
      } else {
        log("Failed to place order for user: $userId, Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("Exception occurred while placing order for user: $userId, Error: $e");
      return false;
    }
  }

  Future<List<OrderGet>> fetchUserOrders(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/orders/user/$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status']) {
          List ordersList = data['orders'];
          return ordersList.map((order) => OrderGet.fromJson(order)).toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception("Error fetching orders: $e");
    }
  }
}
