import 'package:flutter/material.dart';
import '../faqModule/screens/add_faq_screen.dart';
import '../faqModule/screens/faq_screen.dart';
import '../splash_screen.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Faq Screen
    case NamedRoute.faqScreen:
      return _getPageRoute(const FaqScreen());
    // Add Faq Screen
    case NamedRoute.addFaqScreen:
      return _getPageRoute(const AddFaqScreen());
    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
