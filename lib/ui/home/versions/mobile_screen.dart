import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_hourly_statistics.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_nav_bar.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_other_statistics.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_chart.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_forecast.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_map.dart';

import '../../widgets/mobile/mobile_app_bar.dart';

class MobileScreenVersion extends StatelessWidget {
  const MobileScreenVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              scrolledUnderElevation: 0,
              pinned: true,
              collapsedHeight: 150,
              expandedHeight: 400,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxHeight < 350) {
                  return const CollapsedAppBar();
                } else {
                  return const WideAppBar();
                }
              }),
            )
          ];
        },
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            child: Column(
              children: [
                MobileHourlyStatistics(),
                SizedBox(height: 25),
                MobileWeatherForecastWidget(),
                SizedBox(height: 25),
                MobileOtherStatistics(),
                SizedBox(height: 25),
                MobileWeatherChart(),
                SizedBox(height: 25),
                MobileWeatherMap(),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MobileBottomNavigationBar(),
    );
  }
}