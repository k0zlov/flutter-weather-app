import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_app/ui/widgets/language_selector.dart';
import 'package:weather_app/ui/widgets/search_field.dart';
import 'package:weather_app/ui/widgets/theme_switch.dart';
import 'package:weather_app/ui/widgets/units_switch.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/ui/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

import '../../../domen/entities/location_entity.dart';
import '../../../domen/entities/weather_entity.dart';
import '../home_view_model.dart';

class WideScreenVersion extends StatelessWidget {
  const WideScreenVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ContentContainer(height: 300, width: 200, child: WeatherDashboardWidget()),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: ContentContainer(height: 300, width: 200, child: WeatherMapWidget()),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ContentContainer(height: 380, width: 200, child: WeatherChartWidget()),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: ContentContainer(height: 380, width: 200, child: WeatherForecastWidget()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    final DateTime now = DateTime.now();

    final String formattedHour = currentWeather.dateTime.hour.toString().padLeft(2, '0');
    final String formattedMinute = currentWeather.dateTime.minute.toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${daysList[now.weekday - 1]}, ${now.day} ${monthsList[now.month - 1]}, ${now.year}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                'Updated ${currentWeather.dateTime.day} ${daysList[currentWeather.dateTime.weekday]} $formattedHour:$formattedMinute',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          child: Row(
            children: [
              SearchField(),
              SizedBox(width: 20),
              LanguageSelector(),
              SizedBox(width: 20),
              ThemeSwitch(),
              SizedBox(width: 20),
              UnitsSwitch(),
            ],
          ),
        ),
      ],
    );
  }
}
