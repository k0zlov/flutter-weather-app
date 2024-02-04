class HourForecastEntity {
  final DateTime dateTime;
  final int temperature;
  final String icon;

  const HourForecastEntity({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

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