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

  // Future<void> _loadSavedCredentials() async {
  //   final savedCredentials =
  //       await SharedPreferencesHelper.getSavedCredentials();
  //   developer.log('Saved Credentials Email : ${savedCredentials['contact']}');

  //   setState(() {
  //     emailController.text = savedCredentials['contact'] ?? "";
  //     passController.text = savedCredentials['password'] ?? "";
  //     _isRememberMe = savedCredentials['isRememberMe'] ?? "";
  //   });
  // }

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
            statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
            statusBarIconBrightness:
                Brightness.dark, // For Android(M and greater): (dark icons)
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      'assets/applogo/pranshal.png',
                      width: Get.width * 0.4,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: myBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Login to your account.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        TextFormField(
                          cursorColor: primaryColor,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius
                                borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.0), // Set border color and width
                              ),
                              // Optionally, set focused border (when the textfield is focused)
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                              ),
                              // Optionally, set enabled border (when the textfield is enabled but not focused)
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                              ),
                              fillColor: greyColor,
                              filled: true,
                              floatingLabelStyle: floatingLabelTextStyle(),
                              labelStyle: TextStyle(
                                color: textColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              labelText: 'Phone Number',
                              hintText: 'Phone Number'),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        TextFormField(
                          cursorColor: secondaryColor,
                          controller: passController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.go,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius
                                borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.0), // Set border color and width
                              ),
                              // Optionally, set focused border (when the textfield is focused)
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                              ),
                              // Optionally, set enabled border (when the textfield is enabled but not focused)
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                              ),
                              fillColor: greyColor,
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
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: (_showPassword)
                                    ? Icon(
                                        CupertinoIcons.eye_slash,
                                        color: blackColor,
                                      )
                                    : Icon(
                                        CupertinoIcons.eye,
                                        color: blackColor,
                                      ),
                              ),
                              labelText: 'Password',
                              hintText: 'Password'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return primaryColor; // Border color when checked
                                    } else if (states
                                        .contains(MaterialState.disabled)) {
                                      return whiteColor; // Border color when disabled
                                    }
                                    return whiteColor; // Border color when unchecked
                                  }),
                                  checkColor: whiteColor,
                                  value: _isRememberMe,
                                  onChanged: (value) {
                                    toggleRememberMe();
                                  },
                                ),
                                Text("Remember Me",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const ForgetPassword()));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    height: 52,
                    color: primaryColor3,
                    onPressed: login,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                  ),
                  // BlocConsumer<LoginBloc, LoginState>(
                  //   listener: (context, state) {
                  //     if (state is LoginGoogleLoginSuccessfulState ||
                  //         state is LoginSuccessfulState) {
                  //       SharedPreferences.getInstance().then((prefs) {
                  //         prefs.setBool('isLoggedIn', true);
                  //         // Trigger onLoginSuccess callback after successful login
                  //         widget.onLoginSuccess?.call();
                  //       });
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     if (state is LoginLoadingState) {
                  //       return const SizedBox(
                  //           height: 50,
                  //           width: 50,
                  //           child: CupertinoActivityIndicator());
                  //     }
                  //     return MaterialButton(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(18)),
                  //       height: 52,
                  //       color: secondaryColor,
                  //       onPressed: login,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: const [
                  //           Text(
                  //             'Login',
                  //             style: TextStyle(
                  //               color: whiteColor,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(
                    height: Get.height * 0.02,
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
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                  Platform.isAndroid
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox.shrink(),
                  Platform.isAndroid
                      ? SizedBox(
                          width: Get.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: primaryColor,
                                  thickness: 2,
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
                                  color: primaryColor,
                                  thickness: 2,
                                  indent: 5,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Platform.isAndroid
                      ? SizedBox(
                          height: Get.height * 0.012,
                        )
                      : const SizedBox.shrink(),
                  Platform.isAndroid
                      ? GestureDetector(
                          onTap: googleLogin,
                          child: Container(
                            width: Get.width * 0.8,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.03),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 30,
                                  'assets/startup_images/google.png',
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Continue with Google',
                                  style: GoogleFonts.inter(
                                    color: myBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: Get.height * 0.018,
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
