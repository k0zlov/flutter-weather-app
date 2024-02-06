class WeatherHourModel {
  final int? timestamp;
  final double? temperature;
  final String? icon;

  const WeatherHourModel({
    required this.timestamp,
    required this.temperature,
    required this.icon,
  });

  factory WeatherHourModel.fromJson(Map<String, dynamic> json) {
    return WeatherHourModel(
      timestamp: json["dt"],
      temperature: json["main"]["temp"],
      icon: json["weather"][0]["icon"],
    );
  }
}
