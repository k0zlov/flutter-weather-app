import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';
import 'package:weather_app/utils/temperature_converter.dart';

class WideAppBar extends StatelessWidget {
  const WideAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    final int maxTemperature = state.isFahrenheit
        ? TemperatureConverter.celsiusToFahrenheit(currentWeather.maxTemperature)
        : currentWeather.maxTemperature;

    final int minTemperature = state.isFahrenheit
        ? TemperatureConverter.celsiusToFahrenheit(currentWeather.minTemperature)
        : currentWeather.minTemperature;

    final int temperature = state.isFahrenheit
        ? TemperatureConverter.celsiusToFahrenheit(currentWeather.temperature)
        : currentWeather.temperature;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${daysList[currentWeather.dateTime.weekday - 1]}, ${currentWeather.dateTime.day} ${monthsList[currentWeather.dateTime.month - 1]}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4.0),
        Text(
          currentLocation.geocoding.city,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 2.0),
        // Icon logic
        const Icon(
          Icons.cloud,
          size: 130.0,
        ),
        const SizedBox(width: 2.0),
        Text(
          currentWeather.description,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '$temperature°',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 50),
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('H:$maxTemperature°'),
              const MobileVerticalDivider(),
              Text('L:$minTemperature°'),
            ],
          ),
        )
      ],
    );
  }
}

class CollapsedAppBar extends StatelessWidget {
  const CollapsedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    final int temperature = state.isFahrenheit
        ? TemperatureConverter.celsiusToFahrenheit(currentWeather.temperature)
        : currentWeather.temperature;


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud,
              size: 130.0,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${daysList[currentWeather.dateTime.weekday - 1]}, ${currentWeather.dateTime.day} ${monthsList[currentWeather.dateTime.month - 1]}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4.0),
            Text(
              currentLocation.geocoding.city,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleSmall!,
              child: Row(
                children: [
                  Text('$temperature°'),
                  const MobileVerticalDivider(),
                  Text(currentWeather.description),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
