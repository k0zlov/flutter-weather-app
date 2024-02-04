import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';
import 'package:weather_app/ui/widgets/weather_chart.dart';

class MobileWeatherChart extends StatelessWidget {
  const MobileWeatherChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.area_chart,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const MobileVerticalDivider(),
                Text(
                  'Statistics chart',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          const MobileHorizontalDivider(),
          const ChartDataPicker(),
          const MobileHorizontalDivider(),
          const Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Chart(),
          )),
        ],
      ),
    );
  }
}
