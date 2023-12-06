import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/home/home_screen.dart';
import 'package:flutter_defualt_project/ui/on_boarding/on_boarding_screen.dart';
import 'package:flutter_defualt_project/ui/splash/splash_screen.dart';

class RouteNames {
  static const String splash = "/";
  static const String home = "/home";
  static const String onBoarding = "/on_boarding";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found!"),
            ),
          ),
        );
    }
  }
}
