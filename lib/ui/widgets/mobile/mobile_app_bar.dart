import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/dividers.dart';
import 'package:weather_app/utils/temperature_converter.dart';
import 'package:weather_icons/weather_icons.dart';

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

    final String formattedHour = currentWeather.dateTime.hour.toString().padLeft(2, '0');
    final String formattedMinute = currentWeather.dateTime.minute.toString().padLeft(2, '0');

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
          currentLocation.geocoding.city.length > 13
              ? '${currentLocation.geocoding.city.substring(0, 10)}...'
              : currentLocation.geocoding.city,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 2.0),
        // Icon logic
        BoxedIcon(
          currentWeather.icon,
          size: 100.0,
        ),
        const SizedBox(width: 10.0),
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
              const CustomVerticalDivider(),
              Text('L:$minTemperature°'),
            ],
          ),
        ),
        Text(
          'Updated ${currentWeather.dateTime.day} ${daysList[currentWeather.dateTime.weekday]} $formattedHour:$formattedMinute',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxedIcon(
              currentWeather.icon,
              size: 90.0,
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
              currentLocation.geocoding.city.length > 10
                  ? '${currentLocation.geocoding.city.substring(0, 7)}...'
                  : currentLocation.geocoding.city, //currentLocation.geocoding.city,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleSmall!,
              child: Row(
                children: [
                  Text('$temperature°'),
                  const CustomVerticalDivider(),
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
