import 'package:flutter/material.dart';
import '../homeModule/screens/employee_screen.dart';
import '../splash_screen.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Employee Screen / Home Screen
    case NamedRoute.userScreen:
      return _getPageRoute(const EmployeeScreen());
    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
