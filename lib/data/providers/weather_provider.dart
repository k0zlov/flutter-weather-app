import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/data/models/hour_forecast_model.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherDataProvider {


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
