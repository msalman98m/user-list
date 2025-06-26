import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color border;
  final Color brandColor;
  final Color gradientOne;
  final Color gradientTwo;
  final Color heading;
  final Color subheading;
  final Color subtext;
  final Color text;
  final Color cardBackground;
  final Color bgColors;

  const AppColors({
    required this.border,
    required this.bgColors,
    required this.brandColor,
    required this.gradientOne,
    required this.gradientTwo,
    required this.heading,
    required this.subheading,
    required this.subtext,
    required this.text,
    required this.cardBackground,
  });

  static const dark = AppColors(
    bgColors: Color(0xFF16181D),
    border: Color(0xFF6D432F),
    brandColor: Color(0XFF5B71FC),
    gradientOne: Color(0XFF5B69FE),
    gradientTwo: Color(0XFF6498FF),
    heading: Color(0xFFE0E0E0),
    subheading: Color(0xFFC5C5C5),
    subtext: Color(0xFF888888),
    text: Color(0xFFBFBFC4),
    cardBackground: Color(0xFF1E1E1E),
  );
  static const light = AppColors(
    bgColors: Color(0xFFFFFFFF),
    border: Color(0XFFFFE1CA),
    brandColor: Color(0XFF5B71FC),
    gradientOne: Color(0XFF5B69FE),
    gradientTwo: Color(0XFF6498FF),
    heading: Color(0xFF3E3E3E),
    subheading: Color(0xFF515151),
    subtext: Color(0xFF888888),
    text: Color(0xFFACACB4),
    cardBackground: Color(0xFFECF0F9),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? border,
    Color? brandColor,
    Color? gradientOne,
    Color? gradientTwo,
    Color? heading,
    Color? subheading,
    Color? subtext,
    Color? text,
    Color? cardBackground,
    Color? bgColors,
  }) {
    return AppColors(
      bgColors: bgColors ?? this.bgColors,
      border: border ?? this.border,
      brandColor: brandColor ?? this.brandColor,
      gradientOne: gradientOne ?? this.gradientOne,
      gradientTwo: gradientTwo ?? this.gradientTwo,
      heading: heading ?? this.heading,
      subheading: subheading ?? this.subheading,
      subtext: subtext ?? this.subtext,
      text: text ?? this.text,
      cardBackground: cardBackground ?? this.cardBackground,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bgColors: Color.lerp(bgColors, other.bgColors, t)!,
      border: Color.lerp(border, other.border, t)!,
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      gradientOne: Color.lerp(gradientOne, other.gradientOne, t)!,
      gradientTwo: Color.lerp(gradientTwo, other.gradientTwo, t)!,
      heading: Color.lerp(heading, other.heading, t)!,
      subheading: Color.lerp(subheading, other.subheading, t)!,
      subtext: Color.lerp(subtext, other.subtext, t)!,
      text: Color.lerp(text, other.text, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
    );
  }
}
