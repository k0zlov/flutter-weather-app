import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/day_forecast_entity.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/utils/temperature_converter.dart';

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final List<DayForecastEntity> weatherForecastList = currentLocation.weatherForecastList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Forecast', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              ...weatherForecastList.map(
                (e) => ForecastDayWidget(
                  icon: Icons.cloud,
                  minTemp: state.isFahrenheit
                      ? TemperatureConverter.celsiusToFahrenheit(e.minTemperature)
                      : e.minTemperature,
                  maxTemp: state.isFahrenheit
                      ? TemperatureConverter.celsiusToFahrenheit(e.maxTemperature)
                      : e.maxTemperature,
                  day: e.dateTime.day,
                  date: '${monthsList[e.dateTime.month - 1]}, ${daysList[e.dateTime.weekday - 1]}',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ForecastDayWidget extends StatefulWidget {
  const ForecastDayWidget({
    super.key,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
    required this.day,
    required this.date,
  });

  final IconData icon;
  final int minTemp;
  final int maxTemp;
  final int day;
  final String date;

  @override
  State<ForecastDayWidget> createState() => _ForecastDayWidgetState();
}

class _ForecastDayWidgetState extends State<ForecastDayWidget> {
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
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isHovered
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                : Theme.of(context).colorScheme.secondary,
          ),
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: const EdgeInsets.all(12),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineLarge!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(widget.icon, size: 40),
                    const SizedBox(width: 12),
                    Text('${widget.maxTemp}°'),
                    const SizedBox(width: 2),
                    Text(
                      '/ ${widget.minTemp}°',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.day.toString()),
                    const SizedBox(width: 2),
                    Text(
                      widget.date,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
