import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/providers/weather_provider.dart';

import '../entities/weather_entity.dart';

class WeatherRepository {
  final WeatherDataProvider _weatherDataProvider = WeatherDataProvider();

  Future<WeatherEntity> getCurrentWeather({required double lat, required double lon}) async {
    final int hourAmount = 24 - DateTime.now().hour;
    final WeatherModel model = await _weatherDataProvider.getCurrentWeather(
          lat: lat,
          lon: lon,
          hourlyForecastAmount: hourAmount,
        ) ??
        WeatherModel.nullData;

    return WeatherEntity.fromModel(model);
  }
}
