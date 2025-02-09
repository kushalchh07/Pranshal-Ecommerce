import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pranshal_ecommerce/core/theme/ThemeCubit/theme_cubit.dart';
import 'package:pranshal_ecommerce/features/authentication/data/repositories/authentication_repository.dart';
import 'package:pranshal_ecommerce/features/authentication/presentation/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:pranshal_ecommerce/features/authentication/presentation/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/brand_bloc/brand_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/home_bloc/home_page_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/product_bloc/product_bloc.dart';

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
        BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: AuthenticationRepository()),
        ),
        BlocProvider(
          create: (context) =>
              RegisterBloc(authRepository: AuthenticationRepository()),
        ),
        BlocProvider(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => BrandBloc(),
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
