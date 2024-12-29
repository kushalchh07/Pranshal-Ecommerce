import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../../core/constants/strings.dart';

class AuthenticationRepository {
  AuthenticationRepository();

  Future<Map<String, dynamic>> login(String email, String password) async {
    log('login: $email $password');

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      log('login response status: ${response.statusCode}');
      log('login response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body); // Successful login
      } else {
        throw Exception(
            'Login failed. Status code: ${response.statusCode}. Message: ${response.body}');
      }
    } catch (e) {
      log('Error during login: $e');
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>> register(String username, String email,
      String password, String phoneNumber) async {
    log('register: $username $email $password $phoneNumber');

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

      log('register response status: ${response.statusCode}');
      log('register response body: ${response.body}');

      if (response.statusCode == 201) {
        return json.decode(response.body); // Successful registration
      } else {
        throw Exception(
            'Registration failed. Status code: ${response.statusCode}. Message: ${response.body}');
      }
    } catch (e) {
      log('Error during registration: $e');
      throw Exception('Error during registration: $e');
    }
  }
}
