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
  HomeViewModel(this.context) {
    init();
  }

  final BuildContext context;
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
      currentLocation: newLocations.firstOrNull?.id ?? 1,
      isLoading: false,
    );
    notifyListeners();

    for (LocationEntity location in newLocations) {
      await loadLocationChartStatistics(id: location.id);
    }
  }

  Future<void> loadLocationChartStatistics({required int id}) async {
    LocationEntity? changedLocation;

    for (int i = 0; i < _state.locations.length; i++) {
      LocationEntity location = _state.locations[i];
      if (location.id == id) {
        final Map<String, dynamic> lastYearStatistics =
        await _weatherRepository.getLastYearStatistics(geocoding: location.geocoding);

        changedLocation = location.copyWith(
          humidityLastYear: lastYearStatistics['humidity'],
          pressureLastYear: lastYearStatistics['pressure'],
        );

        if (_state.locations.any((location) => location.id == id)) {
          _state.locations[i] = changedLocation;
          _state = _state.copyWith();
          notifyListeners();
        }
        break;
      }
    }
  }

  void deleteLocation({required int id}) {
    final List<LocationEntity> newLocations = _state.locations.where((location) => location.id != id).toList();
    if (id == _state.currentLocation && newLocations.isNotEmpty) {
      changeCurrentLocation(id: newLocations[0].id);
    }
    _state =
        _state.copyWith(locations: newLocations, currentLocation: newLocations.isEmpty ? 1 : _state.currentLocation);
    notifyListeners();
  }

  void changeCurrentLocation({required int id}) {
    _state = _state.copyWith(currentLocation: id);
    final LocationEntity currentLocation =
        _state.locations.singleWhere((location) => location.id == _state.currentLocation);
    if (MediaQuery.of(context).size.width > 915) {
      _mapController.move(LatLng(currentLocation.geocoding.lat, currentLocation.geocoding.lon), 6);
    }
    notifyListeners();
  }

  Future<void> addLocation({required String cityName}) async {
    if (cityName == '') return;

    final GeocodingEntity geocoding = await _geocodingRepository.getEntityByCity(city: cityName);
    final WeatherEntity weather = await _weatherRepository.getCurrentWeather(geocoding: geocoding);
    final List<DayForecastEntity> dailyForecast = await _weatherRepository.getDailyForecast(geocoding: geocoding);
    final LocationEntity newLocation = LocationEntity(
      id: _state.locations.length + 1,
      currentWeather: weather,
      pressureLastYear: [],
      humidityLastYear: [],
      weatherForecastList: dailyForecast,
      geocoding: geocoding,
    );
    _state = _state.copyWith(locations: [..._state.locations, newLocation]);
    _searchController.text = '';
    notifyListeners();
    await loadLocationChartStatistics(id: newLocation.id);
  }

  /// Mobile Dashboard
  void onMenuClicked() {
    _state = _state.copyWith(
      isMobileDashboard: _state.locations.isEmpty ? true : !_state.isMobileDashboard,
    );
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
