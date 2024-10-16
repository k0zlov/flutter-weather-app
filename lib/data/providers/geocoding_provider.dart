import 'dart:convert';

import 'package:weather_app/utils/get_api_key.dart';

import '../models/geocoding_model.dart';
import 'package:http/http.dart' as http;

class GeocodingDataProvider {
  Future<GeocodingModel?> getModelByCity({required String city}) async {
    final uri = Uri.parse('https://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=${getApiKey()}');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonBody != null && jsonBody.isNotEmpty) {
      return GeocodingModel.fromJson(jsonBody[0]);
    } else {
      return null;
    }
  }
}