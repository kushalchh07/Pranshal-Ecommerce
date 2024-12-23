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
  bool _showAcceptMesage = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
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
      child: SafeArea(
        top: Platform.isIOS ? false : true,
        bottom: Platform.isIOS ? false : true,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
              statusBarIconBrightness:
                  Brightness.dark, // For Android(M and greater): (dark icons)
            ),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/applogo/pranshal_bg_removed.png',
                    width: Get.width * 0.4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Create An Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: myBlack,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: secondaryColor,
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        2.0), // Set border radius
                                    borderSide: BorderSide(
                                        color: primaryColor,
                                        width:
                                            1.0), // Set border color and width
                                  ),
                                  // Optionally, set focused border (when the textfield is focused)
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.5),
                                  ),
                                  // Optionally, set enabled border (when the textfield is enabled but not focused)
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.5),
                                  ),
                                  filled: true,
                                  floatingLabelStyle: floatingLabelTextStyle(),
                                  labelStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  labelText: 'Name',
                                  hintText: 'Name'),
                            ),

                            // Email
                            SizedBox(height: Get.height * 0.02),

                            TextFormField(
                              cursorColor: secondaryColor,
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        2.0), // Set border radius
                                    borderSide: BorderSide(
                                        color: primaryColor,
                                        width:
                                            1.0), // Set border color and width
                                  ),
                                  // Optionally, set focused border (when the textfield is focused)
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.5),
                                  ),
                                  // Optionally, set enabled border (when the textfield is enabled but not focused)
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.5),
                                  ),
                                  filled: true,
                                  floatingLabelStyle: floatingLabelTextStyle(),
                                  labelStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  labelText: 'Email',
                                  hintText: 'Email'),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            //Phone Number

                            TextFormField(
                              cursorColor: secondaryColor,
                              controller: contactController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter contact number';
                                }
                                if (value.length < 10) {
                                  return 'Phone Number cannot be less than 10';
                                }
                                if (value.length > 10) {
                                  return 'Phone Number cannot be greater than 10';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set border radius
                                  borderSide: BorderSide(
                                      color: primaryColor,
                                      width: 0.5), // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 0.5),
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 0.5),
                                ),

                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Mobile Number',
                                labelText: 'Mobile Number',
                              ),
                            ),
                            //New Password
                            SizedBox(height: Get.height * 0.02),

                            TextFormField(
                              cursorColor: secondaryColor,
                              controller: newPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter new password';
                                }
                                if (value.length < 8) {
                                  return 'Password should atleast be 8 digits';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.newline,
                              obscureText: !_newPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set border radius
                                  borderSide: BorderSide(
                                      color: primaryColor,
                                      width: 0.5), // Set border color and width
                                ),
                                // Optionally, set focused border (when the textfield is focused)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 0.5),
                                ),
                                // Optionally, set enabled border (when the textfield is enabled but not focused)
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 0.5),
                                ),

                                filled: true,
                                floatingLabelStyle: floatingLabelTextStyle(),
                                labelStyle: TextStyle(
                                  color: textColor,
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

                                hintText: 'Password',
                                labelText: 'Password',
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02),
                          ],
                        )),
                  ),
                  Transform.translate(
                    offset: const Offset(-12, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: agreeTerms,
                          activeColor: secondaryColor, // Active (checked) color
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return secondaryColor; // Checked color
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
                                text: 'I accept the terms and conditions',
                                style: TextStyle(color: greyColorDarker)),
                            TextSpan(
                              text: ' View',
                              style: const TextStyle(
                                  color: secondaryColor,
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
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    height: 52,
                    color: secondaryColor,
                    onPressed: register,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: "Login!",
                              style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
