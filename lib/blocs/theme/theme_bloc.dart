import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../storage_manager.dart';
import '../../theme/app_color.dart';
import 'theme_event.dart';
import 'theme_state.dart';

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<SetDarkMode>(_onSetDarkMode);
    on<SetLightMode>(_onSetLightMode);
  }

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

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final value = await StorageManager.readData('themeMode');
    var themeMode = value ?? 'light';
    if (themeMode == 'light') {
      emit(ThemeLoaded(themeData: lightTheme, isDarkMode: false));
    } else {
      emit(ThemeLoaded(themeData: darkTheme, isDarkMode: true));
    }
  }

  Future<void> _onSetDarkMode(
      SetDarkMode event, Emitter<ThemeState> emit) async {
    StorageManager.saveData('themeMode', 'dark');
    emit(ThemeLoaded(themeData: darkTheme, isDarkMode: true));
  }

  Future<void> _onSetLightMode(
      SetLightMode event, Emitter<ThemeState> emit) async {
    StorageManager.saveData('themeMode', 'light');
    emit(ThemeLoaded(themeData: lightTheme, isDarkMode: false));
  }
}
