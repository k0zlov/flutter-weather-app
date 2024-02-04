import 'package:weather_app/domen/entities/geocoding_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';

class LocationEntity {
  final int id;
  final WeatherEntity currentWeather;
  final List<WeatherEntity> weatherForecastList;
  final GeocodingEntity geocoding;

  const LocationEntity({
    required this.id,
    required this.currentWeather,
    required this.weatherForecastList,
    required this.geocoding,
  });
}