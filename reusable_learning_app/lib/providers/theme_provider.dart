import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class ThemeProvider extends ChangeNotifier {


  ThemeMode themeMode() {
    if (isDarkMode) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  bool get isDarkMode => prefs.getBool("nightMode")!;
  set isDarkMode(value) => prefs.setBool("nightMode", value);

  void toggleTheme(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}