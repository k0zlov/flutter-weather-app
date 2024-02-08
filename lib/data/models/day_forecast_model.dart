class DayForecastModel {
  final double? maxTemperature;
  final double? minTemperature;
  final int? timestamp;
  final String? icon;

  const DayForecastModel({
    required this.maxTemperature,
    required this.minTemperature,
    required this.timestamp,
    required this.icon,
  });

  factory DayForecastModel.fromJson(Map<String, dynamic> json) {
    return DayForecastModel(
      maxTemperature: json['temp']['max']?.toDouble(),
      minTemperature: json['temp']['min']?.toDouble(),
      timestamp: json['dt'],
      icon: json['weather'][0]['icon'],
    );
  }
}
