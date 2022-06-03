import 'package:flutter/material.dart';
import 'package:lime_commerce/router/routeName.dart';
import 'package:lime_commerce/ui/home.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page invalid'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
