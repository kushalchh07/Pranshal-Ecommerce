import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../../core/constants/strings.dart';

class AuthenticationRepository {
  AuthenticationRepository();

  Future<Map<String, dynamic>> login(String email, String password) async {
    log('Initiating login with email: $email');

    try {
      log('Sending POST request to $loginUrl');
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email_address': email,
          'password': password,
        }),
      );

      log('Received response with status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        log('Login successful');
        return json.decode(response.body);
      } else {
        log('Login failed with status code: ${response.statusCode}');
        throw Exception(
            'Login failed. Status code: ${response.statusCode}. Message: ${response.body}');
      }
    } catch (e) {
      log('Error during login process: $e');
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>> register(String username, String email,
      String password, String phoneNumber,String otp) async {
    log('register: $username $email $password $phoneNumber');

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'fullname': username,
          'email_address': email,
          'password': password,
          'contact_number': phoneNumber,
          'otp':otp
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
