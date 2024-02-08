import 'package:weather_app/domen/entities/location_entity.dart';

class HomePageState {
  final bool isFahrenheit;
  final bool isPressure;
  final int currentLocation;
  final bool isLoading;
  final List<LocationEntity> locations;
  final bool isMobileDashboard;

  const HomePageState({
    this.isMobileDashboard = false,
    this.isLoading = true,
    this.isPressure = false,
    this.currentLocation = 0,
    this.isFahrenheit = false,
    this.locations = const [],
  });

  HomePageState copyWith({
    bool? isFahrenheit,
    bool? isPressure,
    int? currentLocation,
    bool? isLoading,
    List<LocationEntity>? locations,
    bool? isMobileDashboard,
  }) {
    return HomePageState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isPressure: isPressure ?? this.isPressure,
      currentLocation: currentLocation ?? this.currentLocation,
      isLoading: isLoading ?? this.isLoading,
      locations: locations ?? this.locations,
      isMobileDashboard: isMobileDashboard ?? this.isMobileDashboard,
    );
  }
}
