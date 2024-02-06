import 'package:flutter/cupertino.dart';
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
    final List<GeocodingEntity> savedGeocodingList = [GeocodingEntity.defaultData];

    for (GeocodingEntity geocoding in savedGeocodingList) {
      final WeatherEntity weather = await _weatherRepository.getCurrentWeather(geocoding: geocoding);
      newLocations.add(
        LocationEntity(
          id: UniqueKey().hashCode,
          currentWeather: weather,
          pressureLastYear: [],
          humidityLastYear: [],
          weatherForecastList: List.generate(
            10,
            (index) => DayForecastEntity(
              maxTemperature: index + 3,
              minTemperature: index - 3,
              dateTime: DateTime.now().copyWith(day: DateTime.now().day + index + 1),
              icon: '03n',
            ),
          ),
          geocoding: geocoding,
        ),
      );
    }
    _state = _state.copyWith(locations: [..._state.locations, ...newLocations], currentLocation: newLocations[0].id);
    notifyListeners();
    await _loadAllLocationsChartStatistics();
  }

  Future<void> _loadAllLocationsChartStatistics() async {
    for (LocationEntity location in state.locations) {
      await loadChartStatistics(id: location.id);
    }
  }

  Future<void> loadChartStatistics({required int id}) async {
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
