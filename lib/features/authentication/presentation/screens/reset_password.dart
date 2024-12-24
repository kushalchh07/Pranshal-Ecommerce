import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/colors.dart';
import 'login_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _newPassword = false;
  bool _confirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => const LoginScreen());
            },
            icon: Icon(
              CupertinoIcons.back,
              color: primaryColor,
            )),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Reset Your Password",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "The password must be different from before",
              style: TextStyle(
                  color: primaryColor.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: Get.width * 0.85,
              child: TextFormField(
                cursorColor: primaryColor2,
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: !_newPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _newPassword = !_newPassword;
                      });
                    },
                    icon: (_newPassword)
                        ? Icon(
                            CupertinoIcons.eye_slash,
                            color: blackColor,
                          )
                        : Icon(
                            CupertinoIcons.eye,
                            color: blackColor,
                          ),
                  ),
                  prefixIcon: const Icon(CupertinoIcons.lock_circle),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(7.0), // Set border radius
                    borderSide: BorderSide(
                        color: primaryColor,
                        width: 0.5), // Set border color and width
                  ),
                  // Optionally, set focused border (when the textfield is focused)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(color: primaryColor, width: 0.5),
                  ),
                  // Optionally, set enabled border (when the textfield is enabled but not focused)
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(color: primaryColor, width: 0.5),
                  ),
                  fillColor: whiteColor,
                  filled: true,
                  floatingLabelStyle: floatingLabelTextStyle(),
                  labelStyle: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  labelText: 'New Password',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: Get.width * 0.85,
              child: TextFormField(
                cursorColor: primaryColor2,
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: !_confirmPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _confirmPassword = !_confirmPassword;
                      });
                    },
                    icon: (_confirmPassword)
                        ? Icon(
                            CupertinoIcons.eye_slash,
                            color: blackColor,
                          )
                        : Icon(
                            CupertinoIcons.eye,
                            color: blackColor,
                          ),
                  ),
                  prefixIcon: const Icon(CupertinoIcons.lock_circle),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(7.0), // Set border radius
                    borderSide: BorderSide(
                        color: primaryColor,
                        width: 0.5), // Set border color and width
                  ),
                  // Optionally, set focused border (when the textfield is focused)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(color: primaryColor, width: 0.5),
                  ),
                  // Optionally, set enabled border (when the textfield is enabled but not focused)
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(color: primaryColor, width: 0.5),
                  ),
                  fillColor: whiteColor,
                  filled: true,
                  floatingLabelStyle: floatingLabelTextStyle(),
                  labelStyle: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 45,
              width: Get.width * 0.85,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
