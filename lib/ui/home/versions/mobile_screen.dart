import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/mobile_dashboard/mobile_dashboard.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_app/ui/widgets/dividers.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_hourly_statistics.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_nav_bar.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_other_statistics.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

import '../../widgets/mobile/mobile_app_bar.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class MobileScreenVersion extends StatelessWidget {
  const MobileScreenVersion({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    return Scaffold(
      body: state.isMobileDashboard ? const MobileDashboardPage() : NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              scrolledUnderElevation: 0,
              pinned: true,
              collapsedHeight: 150,
              expandedHeight: 450,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxHeight < 420) {
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
                NamedContentContainer(
                  width: double.infinity,
                  height: 210,
                  name: 'Hourly forecast',
                  icon: Icons.access_time,
                  child: MobileHourlyStatistics(),
                ),
                SizedBox(height: 25),
                NamedContentContainer(
                  width: double.infinity,
                  height: 620,
                  name: '10-days forecast',
                  icon: Icons.calendar_month_sharp,
                  child: MobileWeatherForecastWidget(),
                ),
                SizedBox(height: 25),
                MobileOtherStatistics(),
                SizedBox(height: 25),
                NamedContentContainer(
                  width: double.infinity,
                  height: 370,
                  name: 'Statistics chart',
                  icon: Icons.area_chart,
                  child: Expanded(
                    child: Column(
                      children: [
                        ChartDataPicker(),
                        CustomHorizontalDivider(),
                        SizedBox(
                            height: 235,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Chart(),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                NamedContentContainer(
                  width: double.infinity,
                  height: 470,
                  name: 'Weather map',
                  icon: Icons.map,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: WeatherMapWidget(),
                    ),
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MobileBottomNavigationBar(),
    );
  }
}
