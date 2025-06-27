import 'package:flutter/material.dart';
import 'package:userlist/theme/app_color.dart';
import '../storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  // Light Theme
  final lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    extensions: const [AppColors.light],
    primaryColor: const Color(0XFF5B71FC),
    brightness: Brightness.light,
    fontFamily: 'Inter',
    cardColor: const Color(0xFFFFF9F4),
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFF6F6F6),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
    ),
  );

  // Dark Theme
  final darkTheme = ThemeData(
    extensions: const [AppColors.dark],
    primarySwatch: Colors.grey,
    primaryColor: const Color(0XFF5B71FC),
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    cardColor: const Color(0xFF262626),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF22262A),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF16181D),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Color(0XFFF0F0F0)),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Color(0XFFF0F0F0)),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Color(0XFFF0F0F0)),
    ),
  );
  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
