import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../internet/data/bloc/internet_bloc.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool _isRememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isLoginWithEmailTapped = false;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _loadSavedCredentials();
  }

  void toggleRememberMe() async {
    setState(() {
      _isRememberMe = !_isRememberMe;
    });
  }

  login() async {}

  googleLogin() async {}

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
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state) {
              case _:
                return loginWidget(context);
            }
          }),
    );
  }

  loginWidget(BuildContext context) {
    return SafeArea(
      top: Platform.isIOS ? false : true,
      bottom: Platform.isIOS ? false : true,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: backgroundColor,
          // surfaceTintColor: backgroundColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light, // For iOS: (dark icons)
            statusBarIconBrightness:
                Brightness.light, // For Android(M and greater): (dark icons)
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/applogo/pranshal_bg_removed.png',
                  width: Get.width * 0.4,
                ),
                Container(
                    width: Get.width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: primaryColor, width: 0.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/email_logo.png",
                            height: 30,
                          ),
                          Text("Login with email.",
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: primaryColor2,
                          thickness: 1,
                          endIndent: 5,
                        ),
                      ),
                      Text(
                        'OR',
                        style: GoogleFonts.inter(
                          color: myBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: primaryColor2,
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
                Container(
                    width: Get.width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: primaryColor, width: 0.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/google_logo.png",
                            height: 30,
                          ),
                          Text("Continue with Google.",
                              style: GoogleFonts.poppins(fontSize: 18)),
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
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: primaryColor, width: 0.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/facebook_logo.png",
                            height: 30,
                          ),
                          Text("Continue with Facebook.",
                              style: GoogleFonts.poppins(fontSize: 18)),
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
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: primaryColor, width: 0.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/apple_logo.png",
                            height: 30,
                          ),
                          Text("Continue with Apple.",
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't Have an Account? ",
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: " Register!",
                        style: const TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Get.to(() => const RegisterScreen());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Terms and conditions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor, // Make the text blue
                            decoration:
                                TextDecoration.underline, // Add underline
                          ),
                        ),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder customFocusBorder() {
  return OutlineInputBorder(
      // borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primaryColor, width: 2));
}

TextStyle floatingLabelTextStyle() {
  return TextStyle(color: secondaryColor, fontSize: 13);
}
