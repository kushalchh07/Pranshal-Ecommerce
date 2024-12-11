import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/authentication/presentation/screens/login_screen.dart';

class AuthGuard {
  // Function to check if the user is logged in
  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the 'isLoggedIn' key exists and its value is true
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Protect route method with async authentication check
  static Route<dynamic> protect(RouteSettings settings, Widget targetScreen) {
    return MaterialPageRoute(
      builder: (_) {
        return FutureBuilder<bool>(
          future: isUserLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading spinner while checking authentication
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData && snapshot.data == true) {
              // User is logged in; navigate to the target screen
              return targetScreen;
            } else {
              // User is not logged in; redirect to LoginScreen
              return const LoginScreen();
            }
          },
        );
      },
    );
  }
}
