import 'package:shared_preferences/shared_preferences.dart';

class UnitsDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<bool> isFahrenheit() async {
    final bool? themeMode = (await _sharedPreferences).getBool('is_fahrenheit');
    return themeMode ?? false;
  }

  Future<void> setFahrenheitBool({required bool isFahrenheit}) async {
    await (await _sharedPreferences).setBool('is_fahrenheit', isFahrenheit);
  }
}