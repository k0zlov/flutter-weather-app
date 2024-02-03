import 'package:weather_app/data/providers/geocoding_provider.dart';

import '../entities/geocoding_entity.dart';

class GeocodingRepository {
  final GeocodingDataProvider _geocodingDataProvider = GeocodingDataProvider();

  Future<GeocodingEntity> getEntityByCity({required String city}) async {
    return GeocodingEntity.fromModel(await _geocodingDataProvider.getModelByCity(city: city));
  }
}