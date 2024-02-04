import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/domen/entities/weather_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';

class MobileOtherStatistics extends StatelessWidget {
  const MobileOtherStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
    state.locations.singleWhere((location) => location.id == state.currentLocation);

    final WeatherEntity currentWeather = currentLocation.currentWeather;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MobileCustomContainer(title: 'Wind speed', value: '${currentWeather.windSpeed} km/h', iconData: Icons.wind_power),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: MobileCustomContainer(title: 'Humidity', value: '${currentWeather.humidity}%', iconData: Icons.water_drop_rounded),
        ),
      ],
    );
  }
}

class MobileCustomContainer extends StatelessWidget {
  const MobileCustomContainer({super.key, required this.title, required this.value, required this.iconData});

  final String title;
  final String value;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      height: 100,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const MobileVerticalDivider(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      ),
                ),
              ],
            ),
          ),
          const MobileHorizontalDivider(),
          Center(child: Text(value, style: Theme.of(context).textTheme.titleLarge)),
        ],
      ),
    );
  }
}
