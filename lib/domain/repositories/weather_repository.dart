import 'package:weather_app/data/models/day_forecast_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/domain/entities/day_forecast_entity.dart';
import 'package:weather_app/domain/entities/geocoding_entity.dart';

import '../entities/weather_entity.dart';

class WeatherRepository {
  final WeatherDataProvider _weatherDataProvider = WeatherDataProvider();

  Future<List<DayForecastEntity>> getDailyForecast({required GeocodingEntity geocoding}) async {
    final List<DayForecastModel> dailyForecast = await _weatherDataProvider.getDailyForecast(
      lat: geocoding.lat,
      lon: geocoding.lon,
      amountOfDays: 10,
    ) ?? [];

    return [...dailyForecast.map((model) => DayForecastEntity.fromModel(model))];
  }

  Future<Map<String, dynamic>> getLastYearStatistics({required GeocodingEntity geocoding}) async {
    DateTime date = DateTime.now().subtract(const Duration(days: 364));

    final List<int> lastYearHumidity = [];
    final List<int> lastYearPressure = [];

    for (int i = 0; i < 52; i++) {
      final int unixDate = date.millisecondsSinceEpoch ~/ 1000;
      final weekStatistics = await _weatherDataProvider.getWeekStatistics(
        lat: geocoding.lat,
        lon: geocoding.lon,
        fromUnixDate: unixDate,
      );
      lastYearPressure
          .add(weekStatistics['pressure'].reduce((int a, int b) => a + b) ~/ weekStatistics['pressure'].length);
      lastYearHumidity
          .add(weekStatistics['humidity'].reduce((int a, int b) => a + b) ~/ weekStatistics['humidity'].length);
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
