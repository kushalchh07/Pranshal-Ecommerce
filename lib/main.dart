import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pranshal_ecommerce/core/theme/ThemeCubit/theme_cubit.dart';

import 'core/navigation/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/internet/data/bloc/internet_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => InternetBloc(Connectivity()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return GetMaterialApp(
            theme: AppTheme.themeData(false, context),
            title: 'Pranshal Clothing',
            initialRoute: AppRouter.splash,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
