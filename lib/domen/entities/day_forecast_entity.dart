import 'package:flutter/material.dart';
import 'package:weather_app/data/models/day_forecast_model.dart';
import 'package:weather_app/utils/icon_converter.dart';

class DayForecastEntity {
  final int maxTemperature;
  final int minTemperature;
  final DateTime dateTime;
  final IconData icon;

  const DayForecastEntity({
    required this.maxTemperature,
    required this.minTemperature,
    required this.dateTime,
    required this.icon,
  });

  factory DayForecastEntity.fromModel(DayForecastModel model) {
    return DayForecastEntity(
      maxTemperature: model.maxTemperature?.toInt() ?? 0,
      minTemperature: model.minTemperature?.toInt() ?? 0,
      dateTime: model.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(model.timestamp! * 1000) : DateTime.now(),
      icon: IconConverter.getIconDataFromIconId(id: model.icon ?? 'xxx'),
    );
  }
}
