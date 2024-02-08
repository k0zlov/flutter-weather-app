import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/home/versions/wide_screen.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_app/ui/widgets/full_screen_search_input.dart';
import 'package:weather_app/ui/widgets/locations_widget.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';
import 'package:weather_app/ui/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

class RestrictedScreenVersion extends StatelessWidget {
  const RestrictedScreenVersion({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    return state.locations.isEmpty
        ? const Scaffold(body: FullScreenSearchInput())
        : const Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBarWidget(),
                    SizedBox(height: 35),
                    ContentContainer(height: 325, width: double.infinity, child: WeatherDashboardWidget()),
                    SizedBox(height: 35),
                    ContentContainer(height: 380, width: double.infinity, child: WeatherChartWidget()),
                    SizedBox(height: 35),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ContentContainer(height: 500, width: 200, child: WeatherForecastWidget()),
                        ),
                        SizedBox(width: 35),
                        Expanded(
                          flex: 1,
                          child: ContentContainer(height: 325, width: 200, child: WeatherMapWidget()),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    LocationsListWidget(),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
  }
}
