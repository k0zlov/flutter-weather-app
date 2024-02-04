import 'package:weather_app/data/providers/units_provider.dart';

class UnitsRepository {
  final UnitsDataProvider _unitsDataProvider = UnitsDataProvider();

  Future<bool> isFahrenheit() async {
    return await _unitsDataProvider.isFahrenheit();
  }

  Future<void> setFahrenheitBool({required bool isFahrenheit}) async {
    await _unitsDataProvider.setFahrenheitBool(isFahrenheit: isFahrenheit);
  }
}