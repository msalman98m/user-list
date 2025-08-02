import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  static double getMaxContentWidth(BuildContext context) {
    // Keep content width similar to mobile portrait
    return 400; // Fixed width for portrait-like appearance
  }

  static Widget getResponsiveContainer(BuildContext context, Widget child) {
    if (isWeb(context)) {
      return Scaffold(
        backgroundColor: Colors.grey[50], // Light background for web
        body: Center(
          child: Container(
            width: getMaxContentWidth(context),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: child,
            ),
          ),
        ),
      );
    }
    return child;
  }
}
