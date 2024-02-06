class HourForecastModel {
  final int? timestamp;
  final double? temperature;
  final String? icon;

  const HourForecastModel({
    required this.timestamp,
    required this.temperature,
    required this.icon,
  });

  factory HourForecastModel.fromJson(Map<String, dynamic> json) {
    return HourForecastModel(
      timestamp: json["dt"],
      temperature: json["main"]["temp"],
      icon: json["weather"][0]["icon"],
    );
  }
}
