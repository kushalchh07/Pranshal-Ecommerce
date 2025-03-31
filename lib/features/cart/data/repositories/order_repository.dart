import 'package:dio/dio.dart';
import 'package:pranshal_ecommerce/core/constants/strings.dart';

import '../models/order_cart_model.dart';

class OrderRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> placeSingleOrder(Order order) async {
    try {
      final response = await _dio.post('/api/orders/place', data: order.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error placing order: $e");
      return false;
    }
  }

  Future<bool> placeCartOrder(int userId, String paymentMethod, String deliveryLocation) async {
    try {
      final response = await _dio.post('/api/orders/place-from-cart/$userId', data: {
        "payment_method": paymentMethod,
        "delivery_location": deliveryLocation,
      });
      return response.statusCode == 200;
    } catch (e) {
      print("Error placing cart order: $e");
      return false;
    }
  }
}
