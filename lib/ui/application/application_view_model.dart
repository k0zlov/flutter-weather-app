import 'package:flutter/material.dart';
import 'package:weather_app/domain/repositories/theme_repository.dart';
import 'package:weather_app/ui/application/application_state.dart';

class ApplicationViewModel extends ChangeNotifier {
  final ThemeRepository _themeRepository = ThemeRepository();
  ApplicationState _state = const ApplicationState();

  ApplicationState get state => _state;

  Future<void> switchTheme() async {
    await _themeRepository.setDarkThemeBool(isDarkTheme: !_state.isDarkTheme);
    _state = _state.copyWith(isDarkTheme: !_state.isDarkTheme);
    notifyListeners();
  }

  Future<void> _setSavedTheme() async {
    final bool isDarkTheme = await _themeRepository.isDarkTheme();
    _state = _state.copyWith(isDarkTheme: isDarkTheme);
    notifyListeners();
  }

  ApplicationViewModel() {
    _setSavedTheme();
  }
}
