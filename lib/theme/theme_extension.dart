import 'package:flutter/material.dart';
import 'app_color.dart';
extension ThemeExtensions on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
