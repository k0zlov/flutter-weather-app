import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<bool> isDarkTheme() async {
    Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final bool? themeMode = (await _sharedPreferences).getBool('is_dark_theme');
    return themeMode ?? brightness == Brightness.dark;
  }

  Future<void> setDarkThemeBool({required bool isDarkTheme}) async {
    await (await _sharedPreferences).setBool('is_dark_theme', isDarkTheme);
  }
}