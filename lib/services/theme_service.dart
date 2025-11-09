import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService _instance = ThemeService._internal();

  ThemeMode _themeMode = ThemeMode.system;

  factory ThemeService() {
    return _instance;
  }

  ThemeService._internal();

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
