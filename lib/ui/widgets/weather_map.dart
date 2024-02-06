import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';

class WeatherMapWidget extends StatelessWidget {
  const WeatherMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);
    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final lat = currentLocation.geocoding.lat;
    final lon = currentLocation.geocoding.lon;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterMap(
        options: MapOptions(initialCenter: LatLng(lat, lon), initialZoom: 4),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          TileLayer(
            urlTemplate: 'http://maps.openweathermap.org/maps/2.0/weather/PA0/{z}/{x}/{y}?date=1552861800&appid=$apiKey',
          )
        ],
      ),
    );
  }
}
