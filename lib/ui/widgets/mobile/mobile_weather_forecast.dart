import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/day_forecast_entity.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/utils/temperature_converter.dart';
import 'package:weather_icons/weather_icons.dart';

import 'mobile_dividers.dart';

class MobileWeatherForecastWidget extends StatelessWidget {
  const MobileWeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final List<DayForecastEntity> weatherForecastList = currentLocation.weatherForecastList;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_sharp,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const MobileVerticalDivider(),
                Text(
                  '10-days forecast',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      ),
                ),
                const MobileHorizontalDivider(),
              ],
            ),
          ),
          const MobileHorizontalDivider(),
          ...weatherForecastList.map(
            (e) => DayForecastWidget(
              minTemp:
                  state.isFahrenheit ? TemperatureConverter.celsiusToFahrenheit(e.minTemperature) : e.minTemperature,
              maxTemp:
                  state.isFahrenheit ? TemperatureConverter.celsiusToFahrenheit(e.maxTemperature) : e.maxTemperature,
              day: '${e.dateTime.day} ${daysList[e.dateTime.weekday - 1]}',
              hasDivider: weatherForecastList[9] != e,
            ),
          ),
        ],
      ),
    );
  }
}

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget(
      {super.key, required this.maxTemp, required this.minTemp, required this.day, required this.hasDivider});

  final int maxTemp;
  final int minTemp;
  final String day;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(day, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(width: 5),
                  const BoxedIcon(WeatherIcons.cloud),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$maxTemp°',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '/ $minTemp°',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        hasDivider ? const MobileHorizontalDivider() : const SizedBox(height: 10),
      ],
    );
  }
}
