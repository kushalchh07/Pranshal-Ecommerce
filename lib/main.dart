
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nep_style/Logic/Bloc/LoginBloc/login_bloc.dart';
import 'package:nep_style/Logic/Bloc/signUpBloc/signup_bloc.dart';
import 'package:nep_style/consts/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
      ],
      child: MaterialApp(title: appname),
    );
  }
}
