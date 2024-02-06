class GeocodingModel {
  final String city;
  final String country;
  final double lat;
  final double lon;

  const GeocodingModel({
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
  });

  static const GeocodingModel defaultData =
      GeocodingModel(city: 'Kyiv', lat: 50.4500336, lon: 30.5241361, country: 'UA');

  factory GeocodingModel.fromJson(Map<String, dynamic> json) {
    return GeocodingModel(
      city: json['name'] as String,
      country: json['country'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }

  GeocodingModel copyWith({
    String? city,
    String? country,
    double? lat,
    double? lon,
  }) {
    return GeocodingModel(
      city: city ?? this.city,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}
