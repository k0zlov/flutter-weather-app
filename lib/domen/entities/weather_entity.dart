import 'package:weather_app/domen/entities/weather_hour_entity.dart';

import '../../data/models/weather_model.dart';

class WeatherEntity {
  final int temperature;
  final DateTime dateTime;
  final int maxTemperature;
  final int minTemperature;
  final String humidity;
  final String windSpeed;
  final List<WeatherHourEntity> hourlyForecast;
  final String icon;
  final String description;

  @override
  String toString() {
    return 'WeatherEntity{temperature: $temperature, dateTime: $dateTime, maxTemperature: $maxTemperature, minTemperature: $minTemperature, humidity: $humidity, windSpeed: $windSpeed, hourlyForecast: $hourlyForecast, icon: $icon, description: $description}';
  }

  factory WeatherEntity.fromModel(WeatherModel model) {
    return WeatherEntity(
      temperature: model.temperature?.toInt() ?? 0,
      dateTime: model.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(model.timestamp! * 1000) : DateTime.now(),
      maxTemperature: model.maxTemperature?.toInt() ?? 0,
      minTemperature: model.minTemperature?.toInt() ?? 0,
      humidity: model.humidity?.toString() ?? 'No data',
      windSpeed: model.windSpeed?.toString() ?? 'No data',
      hourlyForecast: model.hourlyForecast?.map((hourModel) => WeatherHourEntity.fromModel(hourModel)).toList() ??
          List.generate(
            24,
            (index) => WeatherHourEntity(
              dateTime: DateTime.now(),
              temperature: index,
              icon: '03n',
            ),
          ),
      icon: model.icon ?? '03n',
      description: model.description ?? 'No data',
    );
  }

  const WeatherEntity({
    required this.temperature,
    required this.dateTime,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
    required this.icon,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherEntity &&
          runtimeType == other.runtimeType &&
          temperature == other.temperature &&
          dateTime == other.dateTime &&
          maxTemperature == other.maxTemperature &&
          minTemperature == other.minTemperature &&
          humidity == other.humidity &&
          windSpeed == other.windSpeed &&
          hourlyForecast == other.hourlyForecast &&
          icon == other.icon &&
          description == other.description;

  @override
  int get hashCode =>
      temperature.hashCode ^
      dateTime.hashCode ^
      maxTemperature.hashCode ^
      minTemperature.hashCode ^
      humidity.hashCode ^
      windSpeed.hashCode ^
      hourlyForecast.hashCode ^
      icon.hashCode ^
      description.hashCode;
}
