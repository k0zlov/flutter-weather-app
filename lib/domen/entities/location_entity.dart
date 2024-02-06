import 'package:weather_app/domen/entities/day_forecast_entity.dart';
import 'package:weather_app/domen/entities/geocoding_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';

class LocationEntity {
  final int id;
  final WeatherEntity currentWeather;
  final List<int> pressureLastYear;
  final List<int> humidityLastYear;
  final List<DayForecastEntity> weatherForecastList;
  final GeocodingEntity geocoding;

  const LocationEntity({
    required this.id,
    required this.currentWeather,
    required this.pressureLastYear,
    required this.humidityLastYear,
    required this.weatherForecastList,
    required this.geocoding,
  });
}