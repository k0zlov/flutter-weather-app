import 'package:weather_app/data/providers/theme_provider.dart';

class ThemeRepository {
  final ThemeDataProvider _themeDataProvider = ThemeDataProvider();

  Future<bool> isDarkTheme() async {
    return await _themeDataProvider.isDarkTheme();
  }

  Future<void> setDarkThemeBool({required bool isDarkTheme}) async {
    await _themeDataProvider.setDarkThemeBool(isDarkTheme: isDarkTheme);
  }
}