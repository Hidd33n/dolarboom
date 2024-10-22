// lib/theme_mode_notifier.dart
import 'package:flutter/material.dart';

class ThemeModeNotifier extends ChangeNotifier {
  // Singleton instance
  static final ThemeModeNotifier _instance = ThemeModeNotifier._internal();

  factory ThemeModeNotifier() {
    return _instance;
  }

  ThemeModeNotifier._internal();

  // Valor inicial del tema
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  // Singleton para acceder fácilmente desde cualquier parte
  static ThemeModeNotifier get instance => _instance;
}
