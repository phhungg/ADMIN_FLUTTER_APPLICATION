import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const themStatus = "Theme_Status";
  bool _darkTheme = false;
  bool get getIsdarkTheme => _darkTheme;
  ThemeProvider() {
    getTheme();
  }
  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themStatus, themeValue);
    _darkTheme = themeValue;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(themStatus) ?? false;
    notifyListeners();
    return _darkTheme;
  }
}
