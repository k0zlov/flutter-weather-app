import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/domen/entities/day_forecast_entity.dart';
import 'package:weather_app/domen/entities/geocoding_entity.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/domen/repositories/geocoding_repository.dart';
import 'package:weather_app/domen/repositories/units_repository.dart';
import 'package:weather_app/domen/repositories/weather_repository.dart';
import 'package:weather_app/ui/home/home_state.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  final UnitsRepository _unitsRepository = UnitsRepository();
  final WeatherRepository _weatherRepository = WeatherRepository();
  final GeocodingRepository _geocodingRepository = GeocodingRepository();
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  MapController get mapController => _mapController;

  TextEditingController get searchController => _searchController;

  HomePageState _state = const HomePageState();

  HomePageState get state => _state;

  void init() {
    _setSavedUnits();
    _setSavedLocations();
  }

  /// Locations
  Future<void> _setSavedLocations() async {
    final List<LocationEntity> newLocations = [];
    final testData = await _geocodingRepository.getEntityByCity(city: 'Paris');
    final List<GeocodingEntity> savedGeocodingList = [GeocodingEntity.defaultData, testData];

    for (int i = 0; i < savedGeocodingList.length; i++) {
      final GeocodingEntity geocoding = savedGeocodingList[i];
      final WeatherEntity weather = await _weatherRepository.getCurrentWeather(geocoding: geocoding);
      final List<DayForecastEntity> dailyForecast = await _weatherRepository.getDailyForecast(geocoding: geocoding);

      newLocations.add(
        LocationEntity(
          id: i + 1,
          currentWeather: weather,
          pressureLastYear: [],
          humidityLastYear: [],
          weatherForecastList: dailyForecast,
          geocoding: geocoding,
        ),
      );
    }

    _state = _state.copyWith(
      locations: [..._state.locations, ...newLocations],
      currentLocation: newLocations[0].id,
      isLoading: false,
    );
    notifyListeners();

    for (LocationEntity location in state.locations) {
      await loadLocationChartStatistics(id: location.id);
    }
  }

  Future<void> loadLocationChartStatistics({required int id}) async {
    final List<LocationEntity> newLocations = [];
    for (LocationEntity location in state.locations) {
      if (location.id == id) {
        final Map<String, dynamic> lastYearStatistics =
            await _weatherRepository.getLastYearStatistics(geocoding: location.geocoding);

        final changedLocation = location.copyWith(
          humidityLastYear: lastYearStatistics['humidity'],
          pressureLastYear: lastYearStatistics['pressure'],
        );
        newLocations.add(changedLocation);
      } else {
        newLocations.add(location);
      }
    }
    _state = _state.copyWith(locations: newLocations);
    notifyListeners();
  }

  void changeCurrentLocation({required int id}) {
    _state = _state.copyWith(currentLocation: id);
    final LocationEntity currentLocation =
        _state.locations.singleWhere((location) => location.id == _state.currentLocation);

    _mapController.move(LatLng(currentLocation.geocoding.lat, currentLocation.geocoding.lon), 6);
    notifyListeners();
  }

  /// Chart data
  void switchChartData() {
    _state = _state.copyWith(isPressure: !_state.isPressure);
    notifyListeners();
  }

  /// Units
  Future<void> switchUnits() async {
    await _unitsRepository.setFahrenheitBool(isFahrenheit: !_state.isFahrenheit);
    _state = _state.copyWith(isFahrenheit: !_state.isFahrenheit);
    notifyListeners();
  }

  Future<void> _setSavedUnits() async {
    final bool isFahrenheit = await _unitsRepository.isFahrenheit();
    _state = _state.copyWith(isFahrenheit: isFahrenheit);
    notifyListeners();
  }
}
