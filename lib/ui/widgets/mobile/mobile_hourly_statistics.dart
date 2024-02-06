import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domen/entities/weather_hour_entity.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/utils/temperature_converter.dart';

class MobileHourlyStatistics extends StatelessWidget {
  const MobileHourlyStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final List<WeatherHourEntity> hourlyForecastList = currentLocation.currentWeather.hourlyForecast;

    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(20),
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
                    Icons.access_time,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                  const MobileVerticalDivider(),
                  Text(
                    'Hourly forecast',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                  ),
                ],
              ),
            ),
            const MobileHorizontalDivider(),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...hourlyForecastList.map(
                    (e) => HourStatisticsBox(
                      temperature:
                          state.isFahrenheit ? TemperatureConverter.celsiusToFahrenheit(e.temperature) : e.temperature,
                      time: '${e.dateTime.hour}:00',
                      icon: Icons.cloud,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
