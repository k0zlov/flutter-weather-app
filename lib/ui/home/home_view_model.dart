import 'package:flutter/cupertino.dart';
import 'package:weather_app/domen/repositories/units_repository.dart';
import 'package:weather_app/ui/home/home_state.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  final UnitsRepository _unitsRepository = UnitsRepository();
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  HomePageState _state = const HomePageState();

  HomePageState get state => _state;

  void init() {
    _setSavedUnits();
  }

  Future<void> switchUnits() async {
    print(_state.isFahrenheit);
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
