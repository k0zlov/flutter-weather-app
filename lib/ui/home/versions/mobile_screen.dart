import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_hourly_statistics.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_nav_bar.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_chart.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_forecast.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_map.dart';

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

class WideAppBar extends StatelessWidget {
  const WideAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Mon, 13 May',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4.0),
        Text(
          'Kyiv',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 2.0),
        const Icon(
          Icons.cloud,
          size: 130.0,
        ),
        const SizedBox(width: 2.0),
        Text(
          'Cloudy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '23°',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 50),
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('H:11'),
              MobileVerticalDivider(),
              Text('L:26'),
            ],
          ),
        )
      ],
    );
  }
}

class CollapsedAppBar extends StatelessWidget {
  const CollapsedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud,
              size: 130.0,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mon, 13 May',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Kyiv',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleSmall!,
              child: const Row(
                children: [
                  Text('23°'),
                  MobileVerticalDivider(),
                  Text('Cloudy'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
