import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_app/ui/widgets/search_field.dart';
import 'package:weather_icons/weather_icons.dart';

class MobileDashboardPage extends StatelessWidget {
  const MobileDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);


    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SearchField(width: double.infinity, height: 50),
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              children: [
                ...state.locations.map((location) {
                  final WeatherEntity weather = location.currentWeather;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: MobileLocationWidget(
                      maxTemp: weather.maxTemperature,
                      minTemp: weather.minTemperature,
                      cityName: location.geocoding.city,
                      temp: weather.temperature,
                      description: weather.description,
                      icon: weather.icon,
                      onTap: () {
                        viewModel.onMenuClicked();
                        viewModel.changeCurrentLocation(id: location.id);
                      },
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MobileLocationWidget extends StatelessWidget {
  const MobileLocationWidget({
    super.key,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.cityName,
    required this.description, required this.icon, required this.onTap,
  });

  final int maxTemp;
  final int minTemp;
  final int temp;
  final String cityName;
  final String description;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContentContainer(
        width: double.infinity,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BoxedIcon(icon, size: 50),
                      Text(cityName, style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  Text('$temp°', style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineSmall!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(description),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('H:$maxTemp°'),
                        Text('L:$minTemp°'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
