import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';
import 'package:weather_app/ui/widgets/weather_map.dart';

class MobileWeatherMap extends StatelessWidget {
  const MobileWeatherMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      height: 430,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.map,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const MobileVerticalDivider(),
                Text(
                  'Weather map',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          const MobileHorizontalDivider(),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(14.0),
            child: WeatherMapWidget(),
          )),
        ],
      ),
    );
  }
}
