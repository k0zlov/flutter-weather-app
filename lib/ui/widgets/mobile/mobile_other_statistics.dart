import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/entities/location_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/content_container.dart';

class MobileOtherStatistics extends StatelessWidget {
  const MobileOtherStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge!,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NamedContentContainer(
              name: 'Wind speed',
              icon: Icons.wind_power,
              width: 10,
              height: 110,
              child: Center(
                child: Text('${currentWeather.windSpeed} m/s'),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 1,
            child: NamedContentContainer(
              name: 'Humidity',
              icon: Icons.water_drop_rounded,
              width: 10,
              height: 110,
              child: Center(
                child: Text('${currentWeather.humidity}%'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
