import 'package:flutter/material.dart';
import '../homeModule/screens/user_details_screen.dart';
import '../homeModule/screens/user_screen.dart';
import '../splash_screen.dart';
import 'arguments.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoute.userScreen:
      return _getPageRoute(const UserScreen());

    case NamedRoute.userDetailsScreen:
      return _getPageRoute(UserDetailsScreen(
          args: settings.arguments as UserDetailsScreenArguments));
    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
