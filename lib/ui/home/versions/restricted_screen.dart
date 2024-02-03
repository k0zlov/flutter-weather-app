import 'package:flutter/material.dart';
import 'package:weather_app/ui/home/versions/wide_screen.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/ui/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

class RestrictedScreen extends StatelessWidget {
  const RestrictedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          AppBarWidget(),
          SizedBox(height: 35),
          CustomContainer(height: 300, width: double.infinity, child: WeatherDashboardWidget()),
          SizedBox(height: 35),
          CustomContainer(height: 380, width: double.infinity, child: WeatherChartWidget()),
          SizedBox(height: 35),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CustomContainer(height: 500, width: 200, child: WeatherForecastWidget()),
              ),
              SizedBox(width: 35),
              Expanded(
                flex: 1,
                child: CustomContainer(height: 300, width: 200, child: WeatherMapWidget()),
              ),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
