import 'dart:io';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../../../../core/constants/colors.dart';
import '../../../internet/data/bloc/internet_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _newPassword = false;
  bool _confirmPassword = false;
  bool _showAcceptMesage = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactController = TextEditingController();
  final couponController = TextEditingController();
  bool agreeTerms = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    couponController.dispose();
    contactController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
  }

  register() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected) {
          return registerScreen(context);
        }
        return const Scaffold(
          body: Center(
            child: Text('Could not load'),
          ),
        );
      },
    );
  }

  registerScreen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: appBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            width: Get.width * 0.8,
                            child: TextFormField(
                              cursorColor: primaryColor2,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your name';
                                } else if (!RegExp(r'[a-zA-Z]')
                                    .hasMatch(value)) {
                                  return 'Name should contain at least one letter';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(CupertinoIcons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      7.0), // Set border radius
                                  borderSide: BorderSide
                                      .none, // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: primaryColor.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                labelText: 'Name',
                              ),
                            ),
                          ),

                          // Email
                          SizedBox(height: Get.height * 0.02),

                          SizedBox(
                            height: 45,
                            width: Get.width * 0.8,
                            child: TextFormField(
                              cursorColor: primaryColor2,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Email';
                                }

                                // if (!EmailValidator.validate(value)) {
                                //   return 'Invalid email format. Please use a format like \nexample@domain.com.';
                                // }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(CupertinoIcons.mail),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      7.0), // Set border radius
                                  borderSide: BorderSide
                                      .none, // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: primaryColor.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          //Phone Number

                          SizedBox(
                            height: 45,
                            width: Get.width * 0.8,
                            child: TextFormField(
                              cursorColor: primaryColor2,
                              controller: contactController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
                                }
                                if (value.length < 8) {
                                  return 'Password cannot be less than 8';
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(CupertinoIcons.lock_circle),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      7.0), // Set border radius
                                  borderSide: BorderSide
                                      .none, // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: primaryColor.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
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
                                labelText: 'Enter Your Password',
                              ),
                            ),
                          ),
                          //New Password
                          SizedBox(height: Get.height * 0.02),

                          SizedBox(
                            height: 45,
                            width: Get.width * 0.8,
                            child: TextFormField(
                              cursorColor: primaryColor2,
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
                                }
                                if (value.length < 8) {
                                  return 'Password cannot be less than 8';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.newline,
                              obscureText: !_confirmPassword,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(CupertinoIcons.lock_circle),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      7.0), // Set border radius
                                  borderSide: BorderSide
                                      .none, // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none,
                                ),

                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: primaryColor.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
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

                                labelText: 'Confirm Your Password',
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                        ],
                      )),
                ),
                Transform.translate(
                  offset: const Offset(0, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        activeColor: primaryColor2, // Active (checked) color
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return primaryColor2; // Checked color
                            }
                            return Colors.white; // Unchecked (inactive) color
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            agreeTerms = value ?? false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            agreeTerms = !agreeTerms;
                          });
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'I accept the terms and conditions.',
                              style: TextStyle(color: greyColorDarker)),
                          TextSpan(
                            text: ' View',
                            style: TextStyle(
                                color: primaryColor3,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                //
                              },
                          ),
                        ])),
                      ),
                    ],
                  ),
                ),
                _showAcceptMesage == true
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Please accept the terms and services',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 45,
                  width: Get.width * 0.8,
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
                          'Register',
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
        ),
      ),
    );
  }
}
