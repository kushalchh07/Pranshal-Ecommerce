import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pranshal_ecommerce/features/authentication/presentation/screens/email_login_screen.dart';

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
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _loadSavedCredentials();
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.09,
                    ),
                    Image.asset(
                      'assets/applogo/pranshal_login.png',
                      width: Get.width * 0.4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Welcome to Pranshal Clothing",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign Up or Login to Reconnect ",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    const Text("or Begin Your Style Story.",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: TabBar(
                        unselectedLabelColor: greyColor,
                        dividerColor: primaryColor3,
                        labelColor: primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        tabs: const [
                          Tab(text: 'Login'),
                          Tab(text: 'Sign Up'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [EmailLoginScreen(), RegisterScreen()],
                ),
              )
            ],
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
  return TextStyle(color: primaryColor, fontSize: 13);
}
