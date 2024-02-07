import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_app/ui/widgets/language_selector.dart';
import 'package:weather_app/ui/widgets/locations_widget.dart';
import 'package:weather_app/ui/widgets/search_field.dart';
import 'package:weather_app/ui/widgets/theme_switch.dart';
import 'package:weather_app/ui/widgets/units_switch.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/ui/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';


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
                    child: ContentContainer(height: 325, width: 200, child: WeatherDashboardWidget()),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: ContentContainer(height: 325, width: 200, child: WeatherMapWidget()),
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
              ),
              SizedBox(height: 30),
              LocationsListWidget(),
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
    final DateTime now = DateTime.now();

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
