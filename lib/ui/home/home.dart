import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/language_selector.dart';
import 'package:weather_app/ui/widgets/search_field.dart';
import 'package:weather_app/ui/widgets/theme_switch.dart';
import 'package:weather_app/ui/widgets/units_switch.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/ui/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const SafeArea(child: HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: Column(
          children: [
            AppBar(),
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomContainer(height: 300, width: 200, child: WeatherDashboardWidget()),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 1,
                  child: CustomContainer(height: 300, width: 200, child: WeatherMapWidget()),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomContainer(height: 380, width: 200, child: WeatherChartWidget()),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 1,
                  child: CustomContainer(height: 380, width: 200, child: WeatherForecastWidget()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.height, required this.width, required this.child});

  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}


class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Mon, 15 May, 2023', style: Theme.of(context).textTheme.headlineLarge),
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
