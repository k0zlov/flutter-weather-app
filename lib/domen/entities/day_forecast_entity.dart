import 'package:weather_app/data/models/day_forecast_model.dart';

class DayForecastEntity {
  final int maxTemperature;
  final int minTemperature;
  final DateTime dateTime;
  final String icon;

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
      icon: model.icon ?? '03n',
    );
  }
}
