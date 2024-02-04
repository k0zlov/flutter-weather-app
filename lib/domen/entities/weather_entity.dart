import 'package:weather_app/domen/entities/hour_forecast_entity.dart';

class WeatherEntity {
  final int temperature;
  final DateTime dateTime;
  final int maxTemperature;
  final int minTemperature;
  final int humidity;
  final int windSpeed;
  final List<HourForecastEntity> hourlyForecast;
  final List<int> humidityLastYear;
  final List<int> pressureLastYear;
  final String icon;
  final String description;
  final String map;

  const WeatherEntity({
    required this.temperature,
    required this.dateTime,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
    required this.humidityLastYear,
    required this.pressureLastYear,
    required this.icon,
    required this.description,
    required this.map,
  });

  static final defaultData = WeatherEntity(
    temperature: 4,
    dateTime: DateTime.now(),
    maxTemperature: 6,
    minTemperature: -13,
    humidity: 60,
    windSpeed: 13,
    hourlyForecast: List.generate(
      24,
      (index) => HourForecastEntity(dateTime: DateTime(2024, 2, index + 1, index), temperature: index, icon: '03n'),
    ),
    humidityLastYear: List.generate(12 * 30 ~/ 7, (index) => index % 4 == 0 ? index - 5 : index + 6),
    pressureLastYear: List.generate(12 * 30 ~/ 7, (index) => index % 4 == 0 ? index - 1 : index + 2),
    icon: '03n',
    description: 'Cloudy',
    map: 'map',
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherEntity &&
          runtimeType == other.runtimeType &&
          temperature == other.temperature &&
          dateTime == other.dateTime &&
          maxTemperature == other.maxTemperature &&
          minTemperature == other.minTemperature &&
          humidity == other.humidity &&
          windSpeed == other.windSpeed &&
          hourlyForecast == other.hourlyForecast &&
          humidityLastYear == other.humidityLastYear &&
          pressureLastYear == other.pressureLastYear &&
          icon == other.icon &&
          description == other.description &&
          map == other.map;

  @override
  int get hashCode =>
      temperature.hashCode ^
      dateTime.hashCode ^
      maxTemperature.hashCode ^
      minTemperature.hashCode ^
      humidity.hashCode ^
      windSpeed.hashCode ^
      hourlyForecast.hashCode ^
      humidityLastYear.hashCode ^
      pressureLastYear.hashCode ^
      icon.hashCode ^
      description.hashCode ^
      map.hashCode;

  WeatherEntity copyWith({
    int? temperature,
    DateTime? dateTime,
    int? maxTemperature,
    int? minTemperature,
    int? humidity,
    int? windSpeed,
    List<HourForecastEntity>? hourlyForecast,
    List<int>? humidityLastYear,
    List<int>? pressureLastYear,
    String? icon,
    String? description,
    String? map,
  }) {
    return WeatherEntity(
      temperature: temperature ?? this.temperature,
      dateTime: dateTime ?? this.dateTime,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minTemperature: minTemperature ?? this.minTemperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      humidityLastYear: humidityLastYear ?? this.humidityLastYear,
      pressureLastYear: pressureLastYear ?? this.pressureLastYear,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      map: map ?? this.map,
    );
  }
}
