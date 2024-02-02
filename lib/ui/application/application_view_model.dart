import 'package:flutter/material.dart';
import 'package:weather_app/ui/application/application_state.dart';

class ApplicationViewModel extends ChangeNotifier {
  ApplicationState _state = const ApplicationState();
  ApplicationState get state => _state;
}