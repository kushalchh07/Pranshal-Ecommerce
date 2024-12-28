import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/strings.dart';

class AuthenticationRepository {
  final String baseUrl;

  AuthenticationRepository({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
 

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Successful login
      } else {
        throw Exception(
            'Login failed. Status code: ${response.statusCode}. Message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>> register(String username, String email,
      String password, String phoneNumber) async {

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body); // Successful registration
      } else {
        throw Exception(
            'Registration failed. Status code: ${response.statusCode}. Message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }
}
