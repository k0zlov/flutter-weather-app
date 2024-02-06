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
}