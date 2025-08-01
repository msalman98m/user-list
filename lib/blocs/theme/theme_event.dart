import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemeEvent {}

class SetDarkMode extends ThemeEvent {}

class SetLightMode extends ThemeEvent {}
