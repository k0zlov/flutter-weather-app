import 'package:weather_app/data/models/weather_hour_model.dart';

class WeatherHourEntity {
  final DateTime dateTime;
  final int temperature;
  final String icon;

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
      icon: model.icon ?? '03n',
    );
  }

  WeatherHourEntity copyWith({
    DateTime? dateTime,
    int? temperature,
    String? icon,
  }) {
    return WeatherHourEntity(
      dateTime: dateTime ?? this.dateTime,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }
}
