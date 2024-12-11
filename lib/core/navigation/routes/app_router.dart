import 'package:flutter/material.dart';
import 'route_guard.dart';
import '../../../features/authentication/presentation/screens/login_screen.dart';
import '../../../features/authentication/presentation/screens/register_screen.dart';
import '../../../features/cart/presentation/screens/cart.dart';
import '../../../features/home/presentation/screens/homepage.dart';
import '../../../features/startUp/presentation/screens/onboarding.dart';
import '../../../features/startUp/presentation/screens/splash.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return AuthGuard.protect(settings, const SplashScreen());
      case onboarding:
        return AuthGuard.protect(settings, const OnboardingScreen());
      case home:
        return AuthGuard.protect(settings, const HomeScreen());
      case cart:
        return AuthGuard.protect(settings, const CartScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

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
