import 'package:flutter/material.dart';
import '../homeModule/screens/add_user_screen.dart';
import '../homeModule/screens/user_details_screen.dart';
import '../homeModule/screens/user_screen.dart';
import '../splash_screen.dart';
import 'arguments.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // User Screen / Home Screen
    case NamedRoute.userScreen:
      return _getPageRoute(const UserScreen());
    // User Details Screen
    case NamedRoute.userDetailsScreen:
      return _getPageRoute(UserDetailsScreen(
          args: settings.arguments as UserDetailsScreenArguments));
    // Add User Screen
    case NamedRoute.addUserScreen:
      return _getPageRoute(const AddUserScreen());
    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
