import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domen/entities/weather_hour_entity.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/utils/temperature_converter.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/constants.dart';

class WeatherDashboardWidget extends StatelessWidget {
  const WeatherDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final List<WeatherHourEntity> hourlyForecastList = currentLocation.currentWeather.hourlyForecast;

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    final String formattedHour = currentWeather.dateTime.hour.toString().padLeft(2, '0');
    final String formattedMinute = currentWeather.dateTime.minute.toString().padLeft(2, '0');

    return Column(
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.displayMedium!,
          child: const DayStatistics(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...hourlyForecastList.map(
                  (e) {
                    return HourStatisticsBox(
                      temperature:
                          state.isFahrenheit ? TemperatureConverter.celsiusToFahrenheit(e.temperature) : e.temperature,
                      time: '${e.dateTime.hour}:00',
                      icon: e.icon,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Updated ${currentWeather.dateTime.day} ${daysList[currentWeather.dateTime.weekday]} $formattedHour:$formattedMinute',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ),
      ],
    );
  }
}

class HourStatisticsBox extends StatefulWidget {
  const HourStatisticsBox({super.key, required this.temperature, required this.time, required this.icon});

  final int temperature;
  final String time;
  final IconData icon;

  @override
  State<HourStatisticsBox> createState() => _HourStatisticsBoxState();
}

class _HourStatisticsBoxState extends State<HourStatisticsBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: Container(
        decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Theme.of(context).colorScheme.onPrimary, offset: const Offset(-2, 1), blurRadius: 5)
            ]),
        width: 68,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 14,
              ),
          child: Column(
            children: [
              Text(widget.time),
              const SizedBox(height: 2),
              BoxedIcon(widget.icon, color: Theme.of(context).colorScheme.onPrimary),
              const SizedBox(height: 2),
              Text('${widget.temperature}°'),
            ],
          ),
        ),
      ),
    );
  }
}

class DayStatistics extends StatelessWidget {
  const DayStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    final int temperature = state.isFahrenheit
        ? TemperatureConverter.celsiusToFahrenheit(currentWeather.temperature)
        : currentWeather.temperature;

    bool isRestrictedScreen() {
      return MediaQuery.of(context).size.width < 1150;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BoxedIcon(currentWeather.icon, size: 100),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentLocation.geocoding.city.length > (isRestrictedScreen() ? 12 : 16)
                ? '${currentLocation.geocoding.city.substring(0,isRestrictedScreen() ? 9 : 13)}...'
                : currentLocation.geocoding.city),
            Text(currentLocation.geocoding.country, style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('$temperature°'), Text('Temperature', style: Theme.of(context).textTheme.labelLarge)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${currentWeather.humidity}%'),
            Text('Humidity', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(currentWeather.windSpeed.toString()),
                Text('m/s', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),
            Text('Wind speed', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
      ],
    );
  }
}
