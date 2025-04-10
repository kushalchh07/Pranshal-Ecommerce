import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/strings.dart';
import '../models/review_model.dart';

class ReviewRepository {
  // Get reviews for a product
  Future<List<Review>> getReviews(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/reviews/list?product_id=$productId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true && responseData['data'] != null) {
          final List<dynamic> reviewsJson = responseData['data'];
          return reviewsJson.map((json) => Review.fromJson(json)).toList();
        } else {
          // Empty list if no data
          return [];
        }
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
      throw Exception('Failed to load reviews: $e');
    }
  }

  // Submit a review
  Future<bool> submitReview(Review review) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/reviews/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'product_id': review.productId,
          'user_id': review.userId,
          'user_name': review.userName,
          'comment': review.comment,
          'rating': review.rating,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['status'] == true;
      } else {
        print('Server error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error submitting review: $e');
      return false;
    }
  }
}
