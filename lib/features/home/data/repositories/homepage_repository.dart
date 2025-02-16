import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pranshal_ecommerce/core/constants/strings.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

class HomePageRepository {
  // Change to your deployed API

  Future<HomeModel> fetchHomeData() async {
    try {
      log("Fetching home data from $homeUrl");
      final response = await http.get(Uri.parse(homeUrl));

      if (response.statusCode == 200) {
        log("Successfully fetched home data");
        return HomeModel.fromJson(jsonDecode(response.body));
      } else {
        log("Failed to fetch home data: ${response.statusCode}");
        throw Exception("Failed to load home data");
      }
    } catch (e) {
      log("An error occurred while fetching home data: $e");
      rethrow;
    }
  }

  Future<void> logUserActivity(
      int userId, int productId, String actionType) async {
    log("Logging user activity: userId=$userId, productId=$productId, actionType=$actionType");
    final response = await http.post(
      Uri.parse('$baseUrl/api/log-activity'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'product_id': productId,
        'action_type': actionType,
      }),
    );

    if (response.statusCode == 200) {
      log("Successfully logged user activity");
    } else {
      log("Failed to log user activity: ${response.statusCode}");
      throw Exception('Failed to log user activity');
    }
  }
}
