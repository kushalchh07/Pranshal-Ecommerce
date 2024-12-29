import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/features/base/presentation/screens/base.dart';
import '../../../features/startUp/presentation/screens/splash.dart';
import '../../../features/authentication/presentation/screens/login_screen.dart';
import '../../../features/authentication/presentation/screens/register_screen.dart';
import '../../../features/cart/presentation/screens/cart.dart';
import '../../../features/home/presentation/screens/homepage.dart';
import '../../../features/startUp/presentation/screens/onboarding.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String register = '/register';
  static const String base='/base';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
         case base:
        return MaterialPageRoute(builder: (_) => const Base());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
