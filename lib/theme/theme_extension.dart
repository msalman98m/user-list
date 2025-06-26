import 'package:flutter/material.dart';
import 'app_color.dart';

/// Extension on BuildContext to easily access theme extensions
extension ThemeExtensions on BuildContext {
  /// Get the AppColors extension from the current theme
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}


//TO USE THIS
// import 'package:sg_guard_app/theme/theme_extension.dart';

// context.colors.specialCard 