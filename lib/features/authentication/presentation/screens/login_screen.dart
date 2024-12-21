import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor, fontSize: 40),
            ),
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor1, fontSize: 40),
            ),
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor2, fontSize: 40),
            ),
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor3, fontSize: 40),
            ),
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor4, fontSize: 40),
            ),
            Text(
              'Login Screen',
              style: TextStyle(color: primaryColor5, fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
