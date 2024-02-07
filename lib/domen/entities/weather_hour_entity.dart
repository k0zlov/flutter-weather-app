import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_hour_model.dart';
import 'package:weather_app/utils/icon_converter.dart';

class WeatherHourEntity {
  final DateTime dateTime;
  final int temperature;
  final IconData icon;

  const WeatherHourEntity({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  @override
  String toString() {
    return 'HourForecastEntity{dateTime: $dateTime, temperature: $temperature, icon: $icon}';
  }

  factory WeatherHourEntity.fromModel(WeatherHourModel model) {
    return WeatherHourEntity(
      dateTime: model.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(model.timestamp! * 1000) : DateTime.now(),
      temperature: model.temperature?.toInt() ?? 0,
      icon: IconConverter.getIconDataFromIconId(id: model.icon ?? 'xxx'),
    );
  }

  WeatherHourEntity copyWith({
    DateTime? dateTime,
    int? temperature,
    IconData? icon,
  }) {
    return WeatherHourEntity(
      dateTime: dateTime ?? this.dateTime,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }
}
