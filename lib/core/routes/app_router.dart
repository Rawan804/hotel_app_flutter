import 'package:flutter/material.dart';

import '../../features/onboarding/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(
      RouteSettings settings) {

    switch (settings.name) {

      case '/':
        return MaterialPageRoute(
          builder: (_) =>
          const SplashScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const SplashScreen(),
        );
    }
  }
}