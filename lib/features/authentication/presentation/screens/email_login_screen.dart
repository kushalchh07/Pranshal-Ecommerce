import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/colors.dart';
import '../../../base/presentation/screens/base.dart';
import '../bloc/login_bloc/bloc/login_bloc.dart';
import '../bloc/login_bloc/bloc/login_event.dart';
import '../bloc/login_bloc/bloc/login_state.dart';
import 'forget_password.dart';
import 'login_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  bool _showPassword = false;
  bool _isRememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggleRememberMe() async {
    setState(() {
      _isRememberMe = !_isRememberMe;
    });
  }

  /// Set the login status in shared preference
  ///
  /// This function stores the login status in shared preference. The key is
  /// 'isLoggedIn' and the value is a boolean.
  ///
  /// This function is used in the login process to store the login status after
  /// a successful login.
  ///
  Future<void> setLoginStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  login() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      {
        BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
            email: emailController.text.trim(),
            password: passController.text.trim()));
        await clearControllers();
      }
    }
  }

  googleLogin() async {}
  facebookLogin() async {}
  appleLogin() async {}
  clearControllers() {
    emailController.clear();
    passController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(color: appBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: Get.width * 0.8,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: whiteColor),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/google_logo.png",
                          height: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Continue with Google.",
                            style: GoogleFonts.poppins(fontSize: 16)),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: Get.width * 0.8,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: whiteColor),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/facebook_logo.png",
                          height: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Continue with Facebook.",
                            style: GoogleFonts.poppins(fontSize: 16)),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              Platform.isIOS
                  ? Container(
                      width: Get.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: whiteColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/apple_logo.png",
                              height: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Continue with Apple.",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          ],
                        ),
                      ))
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width * 0.8,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: primaryColor3,
                        thickness: 1,
                        endIndent: 5,
                      ),
                    ),
                    Text(
                      'or continue with email',
                      style: GoogleFonts.inter(
                        color: greyColorDarker,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: primaryColor3,
                        thickness: 1,
                        indent: 5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: formKey,
                child: Column(children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    height: 45,
                    child: TextFormField(
                      cursorColor: primaryColor4,
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
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          color: primaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(7.0), // Set border radius
                          borderSide:
                              BorderSide.none, // Set border color and width
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
                        labelText: 'Email your email',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: Get.width * 0.8,
                    height: 45,
                    child: TextFormField(
                      cursorColor: primaryColor4,
                      controller: passController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }

                        // if (!EmailValidator.validate(value)) {
                        //   return 'Invalid email format. Please use a format like \nexample@domain.com.';
                        // }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // Trigger your button when "Next" is pressed
                        //can implement the login logic from here.
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.lock_circle,
                          color: primaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(7.0), // Set border radius
                          borderSide:
                              BorderSide.none, // Set border color and width
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
                        labelText: 'Email your password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor2,
                            ),
                          )),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 45,
                width: Get.width * 0.8,
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginFailure) {
                      Fluttertoast.showToast(
                        msg: 'Login Failed',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: whiteColor,
                      );
                    }
                    if (state is LoginSuccess) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      Fluttertoast.showToast(
                        msg: 'Login Successful',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: whiteColor,
                      );
                      Get.offAll(() => const Base());
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }

                    return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(primaryColor),
                          elevation: const WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )),
                      onPressed: () async {
                        login();
                        //as of now this setlogin status goes here otherwise, when the login successfull state is emitted then we set the login statuss to true.
                        // await setLoginStatus(true);
                        // Get.to(() => const Base());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    text: 'Joining our app means you agree with our ',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms and conditions',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: primaryColor2, // Make the text blue
                          decoration: TextDecoration.underline, // Add underline
                        ),
                      ),
                      const TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
