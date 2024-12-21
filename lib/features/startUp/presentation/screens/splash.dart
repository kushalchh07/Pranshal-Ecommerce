import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/navigation/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the user is logged in
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigate to Onboarding if first launch or Home if logged in
    if (isLoggedIn) {
      // Delay to simulate splash duration
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, AppRouter.home);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, AppRouter.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo or splash image
            Image.asset(
              'assets/startup/pranshal_gif.gif', // Replace with your asset path
              height: 150,
            ),
            // const SizedBox(height: 20),
            // // Add a loading indicator
            // const CircularProgressIndicator(),
            // const SizedBox(height: 20),
            // // Optional text
            // const Text(
            //   'Welcome to Pranshal Clothing',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
