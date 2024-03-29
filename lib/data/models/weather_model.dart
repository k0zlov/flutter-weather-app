import 'package:weather_app/data/models/weather_hour_model.dart';

class WeatherModel {
  final double? temperature;
  final int? timestamp;
  final double? maxTemperature;
  final double? minTemperature;
  final int? humidity;
  final double? windSpeed;
  final List<WeatherHourModel>? hourlyForecast;
  final String? icon;
  final String? description;

  const WeatherModel({
    required this.temperature,
    required this.timestamp,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
    required this.icon,
    required this.description,
  });

  static const nullData = WeatherModel(
    temperature: null,
    timestamp: null,
    maxTemperature: null,
    minTemperature: null,
    humidity: null,
    windSpeed: null,
    hourlyForecast: null,
    icon: null,
    description: null,
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final mainData = json['main'];
    final weatherData = json['weather'][0];
    final windData = json['wind'];

    return WeatherModel(
      temperature: mainData['temp'],
      timestamp: json['dt'],
      maxTemperature: mainData['temp_max'],
      minTemperature: mainData['temp_min'],
      humidity: mainData['humidity'],
      windSpeed: windData['speed'],
      hourlyForecast: [],
      icon: weatherData['icon'],
      description: weatherData['description'],
    );
  }

  WeatherModel copyWith({
    double? temperature,
    int? timestamp,
    double? maxTemperature,
    double? minTemperature,
    int? humidity,
    double? windSpeed,
    List<WeatherHourModel>? hourlyForecast,
    String? icon,
    String? description,
  }) {
    return WeatherModel(
      temperature: temperature ?? this.temperature,
      timestamp: timestamp ?? this.timestamp,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minTemperature: minTemperature ?? this.minTemperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      icon: icon ?? this.icon,
      description: description ?? this.description,
    );
  }
}
