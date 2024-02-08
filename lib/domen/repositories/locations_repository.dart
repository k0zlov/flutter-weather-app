import 'package:weather_app/data/providers/locations_provider.dart';
import 'package:weather_app/domen/entities/geocoding_entity.dart';

class LocationsRepository {
  final LocationsDataProvider _locationsDataProvider = LocationsDataProvider();

  Future<List<GeocodingEntity>> getSavedLocations() async {
    return await _locationsDataProvider.getLocations();
  }

  Future<void> deleteLocation({required GeocodingEntity geocoding}) async {
    await _locationsDataProvider.deleteLocation(geocoding: geocoding);
  }

  Future<void> saveLocation({required GeocodingEntity geocoding}) async {
    await _locationsDataProvider.saveLocation(geocoding: geocoding);
  }
}