import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier,WidgetsBindingObserver {

  bool _isDarkMode = false;
  Brightness _platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  Brightness get platformBrightness => _platformBrightness;

  bool get isDarkMode => _platformBrightness == Brightness.dark;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  @override
  void didChangePlatformBrightness() {
    _platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      _platformBrightness = Brightness.dark;
    } else {
      _platformBrightness = Brightness.light;
    }
    notifyListeners();
  }
}
