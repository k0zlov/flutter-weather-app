import 'package:weather_app/data/models/geocoding_model.dart';

class GeocodingEntity {
  final String city;
  final String country;
  final double lat;
  final double lon;

  const GeocodingEntity({
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
  });

  static const GeocodingEntity defaultData =
      GeocodingEntity(city: 'Kyiv', lat: 50.4500336, lon: 30.5241361, country: 'UA');

  GeocodingEntity copyWith({
    String? city,
    String? country,
    double? lat,
    double? lon,
  }) {
    return GeocodingEntity(
      city: city ?? this.city,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  factory GeocodingEntity.fromModel(GeocodingModel model) {
    return GeocodingEntity(city: model.city, country: model.country, lat: model.lat, lon: model.lon);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "country": country,
      "city": city,
      "lat": lat,
      "lon": lon,
    };
  }

  factory GeocodingEntity.fromJson(Map<String, dynamic> json) {
    return GeocodingEntity(
      country: json['country'],
      city: json['city'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}
