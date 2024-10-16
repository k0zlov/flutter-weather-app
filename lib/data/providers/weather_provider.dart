import 'dart:convert';

import 'package:weather_app/data/models/day_forecast_model.dart';
import 'package:weather_app/data/models/weather_hour_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/get_api_key.dart';

import '../models/weather_model.dart';

class WeatherDataProvider {
  Future<List<DayForecastModel>?> getDailyForecast(
      {required double lat, required double lon, required int amountOfDays}) async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=$amountOfDays&appid=${getApiKey()}&units=metric');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<DayForecastModel> dayForecastList = [];

      for (final day in jsonBody['list']) {
        dayForecastList.add(DayForecastModel.fromJson(day));
      }

      return dayForecastList;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> getWeekStatistics(
      {required double lat, required double lon, required int fromUnixDate}) async {
    final uri = Uri.parse(
        'https://history.openweathermap.org/data/2.5/history/city?lat=$lat&lon=$lon&type=hour&start=$fromUnixDate&appid=${getApiKey()}&cnt=168&units=metric');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<int> weekPressure = [];
      final List<int> weekHumidity = [];
      for (final hour in jsonBody['list']) {
        weekPressure.add(hour['main']['pressure']);
        weekHumidity.add(hour['main']['humidity']);
      }
      return {'pressure': weekPressure, 'humidity': weekHumidity};
    } else {
      return {'pressure': [], 'humidity': []};
    }
  }

  Future<List<WeatherHourModel>?> getHourlyForecast({required double lat, required double lon, required amount}) async {
    final uri = Uri.parse(
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&appid=${getApiKey()}&units=metric&cnt=$amount');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<WeatherHourModel> hourlyData = [];

      for (final hour in jsonBody['list']) {
        hourlyData.add(WeatherHourModel.fromJson(hour));
      }
      return hourlyData;
    } else {
      return null;
    }
  }

  Future<WeatherModel?> getCurrentWeather(
      {required double lat, required double lon, required int hourlyForecastAmount}) async {
    final uri =
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${getApiKey()}&units=metric');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      final List<WeatherHourModel> hourlyForecast = await getHourlyForecast(lat: lat, lon: lon, amount: 24) ?? [];

      return WeatherModel.fromJson(jsonBody).copyWith(hourlyForecast: hourlyForecast);
    } else {
      return null;
    }
  }
}
