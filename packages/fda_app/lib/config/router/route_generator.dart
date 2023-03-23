import 'package:fda_app/Screens/History/history.dart';
import 'package:fda_app/Screens/Home/home.dart';
import 'package:fda_app/Screens/Login/login.dart';
import 'package:fda_app/config/common/custom_page_route.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CustomPageRoute(
          settings: const RouteSettings(name: '/'),
          child: const LoginPage(),
        );
      case '/home':
        return CustomPageRoute(
          settings: const RouteSettings(name: '/detail'),
          child: Home(),
        );
      case '/history':
        return CustomPageRoute(
          settings: const RouteSettings(name: '/cart'),
          child: const History(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(child: Text("Not found")),
      );
    });
  }
}
