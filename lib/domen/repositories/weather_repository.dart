import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/domen/entities/geocoding_entity.dart';

import '../entities/weather_entity.dart';

class WeatherRepository {
  final WeatherDataProvider _weatherDataProvider = WeatherDataProvider();

  Future<Map<String, dynamic>> getLastYearStatistics({required GeocodingEntity geocoding}) async {
    DateTime date = DateTime.now().subtract(const Duration(days: 364));

    final List<int> lastYearHumidity = [];
    final List<int> lastYearPressure = [];

    for (int i = 0; i < 52; i++) {
      print(date);
      final int unixDate = date.millisecondsSinceEpoch ~/ 1000;
      final weekHumidity = await _weatherDataProvider.getWeekHumidityFromDate(
        lat: geocoding.lat,
        lon: geocoding.lon,
        fromUnixDate: unixDate,
      );
      final weekPressure = await _weatherDataProvider.getWeekPressureFromDate(
        lat: geocoding.lat,
        lon: geocoding.lon,
        fromUnixDate: unixDate,
      );

      lastYearPressure.add(weekPressure.reduce((a, b) => a + b) ~/ weekPressure.length);
      lastYearHumidity.add(weekHumidity.reduce((a, b) => a + b) ~/ weekHumidity.length);
      date = date.add(const Duration(days: 7));
    }
    return {'pressure': lastYearPressure, 'humidity': lastYearHumidity};
  }

  Future<WeatherEntity> getCurrentWeather({required GeocodingEntity geocoding}) async {
    final int hourAmount = 24 - DateTime.now().hour;
    final WeatherModel model = await _weatherDataProvider.getCurrentWeather(
          lat: geocoding.lat,
          lon: geocoding.lon,
          hourlyForecastAmount: hourAmount,
        ) ??
        WeatherModel.nullData;

    return WeatherEntity.fromModel(model);
  }
}
