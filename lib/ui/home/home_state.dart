import 'package:weather_app/domen/entities/location_entity.dart';

class HomePageState {
  final bool isFahrenheit;
  final bool isPressure;
  final int currentLocation;
  final List<LocationEntity> locations;

  const HomePageState({
    this.isPressure = false,
    this.currentLocation = 0,
    this.isFahrenheit = false,
    this.locations = const [],
  });

  HomePageState copyWith({
    bool? isFahrenheit,
    bool? isPressure,
    int? currentLocation,
    List<LocationEntity>? locations,
  }) {
    return HomePageState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isPressure: isPressure ?? this.isPressure,
      currentLocation: currentLocation ?? this.currentLocation,
      locations: locations ?? this.locations,
    );
  }
}
