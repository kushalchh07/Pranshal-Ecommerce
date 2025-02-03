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
}
