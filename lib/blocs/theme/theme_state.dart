import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeLoaded({required this.themeData, required this.isDarkMode});

  @override
  List<Object> get props => [themeData, isDarkMode];
}
