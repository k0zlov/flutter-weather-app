import 'package:weather_app/domain/entities/geocoding_entity.dart';
import 'package:weather_app/utils/database_handler.dart';

class LocationsDataProvider {
  final DatabaseHandler<GeocodingEntity> databaseHandler = DatabaseHandler<GeocodingEntity>(
    tableName: 'locations',
    fromJson: (json) => GeocodingEntity.fromJson(json),
    toJson: (location) => location.toJson(),
  );


  Future<int> saveLocation({required GeocodingEntity geocoding}) async {
    return await databaseHandler.insert(geocoding);
  }

  Future<List<GeocodingEntity>> getLocations() async {
    return await databaseHandler.getAll();
  }

  Future<int> deleteLocation({required GeocodingEntity geocoding}) async {
    return await databaseHandler.delete(where: 'lon = ? AND lat = ?', whereArgs: [geocoding.lon, geocoding.lat]);
  }
}