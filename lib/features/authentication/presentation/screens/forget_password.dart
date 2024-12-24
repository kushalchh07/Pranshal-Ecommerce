import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/colors.dart';
import 'login_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: primaryColor,
              )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Forget Password",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter You Email address to reset your password.",
              style: TextStyle(
                  color: primaryColor.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset(
                'assets/others/forget_password.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: Get.width * 0.85,
              child: TextFormField(
                cursorColor: primaryColor2,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.mail),
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
                  labelText: 'Enter your Email',
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
                      'Send',
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
