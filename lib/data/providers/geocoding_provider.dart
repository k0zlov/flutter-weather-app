import 'dart:convert';

import '../../constants/constants.dart';
import '../models/geocoding_model.dart';
import 'package:http/http.dart' as http;

class GeocodingDataProvider {
  Future<GeocodingModel> getModelByCity({required String city}) async {
    final uri = Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey');
    final response = await http.get(uri);
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonBody != null && jsonBody.isNotEmpty) {
        return GeocodingModel.fromJson(jsonBody[0]);
      } else {
        return GeocodingModel.defaultData;
      }
    } else {
      throw Exception('Failed to load data by city name.');
    }
  }
}