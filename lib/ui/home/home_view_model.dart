import 'package:flutter/cupertino.dart';
import 'package:weather_app/ui/home/home_state.dart';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  HomePageState _state = HomePageState();

  HomePageState get state => _state;
}
