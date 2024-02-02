import 'package:flutter/cupertino.dart';
import 'package:weather_app/ui/home/home_state.dart';

class HomeViewModel extends ChangeNotifier {
  HomePageState _state = HomePageState();
  HomePageState get state => _state;
}