import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/data/models/hour_forecast_model.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherDataProvider {
  Future<Map<String, dynamic>> getWeekStatistics({required double lat, required double lon, required int fromUnixDate}) async {
    final uri = Uri.parse(
        'https://history.openweathermap.org/data/2.5/history/city?lat=$lat&lon=$lon&type=hour&start=$fromUnixDate&appid=$apiKey&cnt=168');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<int> weekPressure = [];
      final List<int> weekHumidity = [];
      for(final hour in jsonBody['list']) {
        weekPressure.add(hour['main']['pressure']);
        weekHumidity.add(hour['main']['humidity']);
      }
      return {'pressure': weekPressure, 'humidity': weekHumidity};
    } else {
      return {'pressure': [], 'humidity': []};
    }
  }

  /// DEPRECATED
  Future<List<int>> getWeekPressureFromDate({required double lat, required double lon, required int fromUnixDate}) async {
    final uri = Uri.parse(
        'https://history.openweathermap.org/data/2.5/history/city?lat=$lat&lon=$lon&type=hour&start=$fromUnixDate&appid=$apiKey&cnt=168');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<int> weekPressure = [];
      for(final hour in jsonBody['list']) {
        weekPressure.add(hour['main']['pressure']);
      }
      return weekPressure;
    } else {
      return [];
    }
  }

  /// DEPRECATED
  Future<List<int>> getWeekHumidityFromDate({required double lat, required double lon, required int fromUnixDate}) async {
    final uri = Uri.parse(
        'https://history.openweathermap.org/data/2.5/history/city?lat=$lat&lon=$lon&type=hour&start=$fromUnixDate&appid=$apiKey&cnt=168');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<int> weekHumidity = [];
      for(final hour in jsonBody['list']) {
        weekHumidity.add(hour['main']['humidity']);
      }
      return weekHumidity;
    } else {
      return [];
    }
  }

  Future<List<HourForecastModel>?> getHourlyForecast(
      {required double lat, required double lon, required amount}) async {
    final uri = Uri.parse(
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&appid=$apiKey&units=metric&cnt=$amount');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<HourForecastModel> hourlyData = [];

      for (final hour in jsonBody['list']) {
        hourlyData.add(HourForecastModel.fromJson(hour));
      }
      return hourlyData;
    } else {
      return null;
    }
  }

  Future<WeatherModel?> getCurrentWeather(
      {required double lat, required double lon, required int hourlyForecastAmount}) async {
    final uri =
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<HourForecastModel> hourlyForecast =
          await getHourlyForecast(lat: lat, lon: lon, amount: hourlyForecastAmount) ?? [];

      return WeatherModel.fromJson(jsonBody).copyWith(hourlyForecast: hourlyForecast);
    } else {
      return null;
    }
  }
}
