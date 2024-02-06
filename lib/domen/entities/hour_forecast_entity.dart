import 'package:weather_app/data/models/hour_forecast_model.dart';

class HourForecastEntity {
  final DateTime dateTime;
  final int temperature;
  final String icon;

  const HourForecastEntity({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  @override
  String toString() {
    return 'HourForecastEntity{dateTime: $dateTime, temperature: $temperature, icon: $icon}';
  }

  factory HourForecastEntity.fromModel(HourForecastModel model) {
    return HourForecastEntity(
      dateTime: model.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(model.timestamp! * 1000) : DateTime.now(),
      temperature: model.temperature?.toInt() ?? 0,
      icon: model.icon ?? '03n',
    );
  }

  HourForecastEntity copyWith({
    DateTime? dateTime,
    int? temperature,
    String? icon,
  }) {
    return HourForecastEntity(
      dateTime: dateTime ?? this.dateTime,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }
}
