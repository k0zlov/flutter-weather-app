import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_icons/weather_icons.dart';

import 'mobile_dividers.dart';

class MobileWeatherForecastWidget extends StatelessWidget {
  const MobileWeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentDay = DateTime.now().weekday;
    final List<String> currentDaysList = [];
    for(int i = currentDay; i < daysList.length; i++) {
      currentDaysList.add(daysList[i]);
    }
    for(int i = 0; i < currentDay; i++) {
      currentDaysList.add(daysList[i]);
    }
    print(currentDaysList);
    final List<List<dynamic>> items = List.generate(
      10,
      (index) => [index + 3, index - 3, currentDaysList[index > 6 ? index - 7 : index], index],
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_sharp,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const MobileVerticalDivider(),
                Text(
                  '10-days forecast',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      ),
                ),
                const MobileHorizontalDivider(),
              ],
            ),
          ),
          const MobileHorizontalDivider(),
          ...items.map((e) => DayForecastWidget(minTemp: e[1], maxTemp: e[0], day: e[2], hasDivider: e[3] != 9,)),
        ],
      ),
    );
  }
}

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget({super.key, required this.maxTemp, required this.minTemp, required this.day, required this.hasDivider});

  final int maxTemp;
  final int minTemp;
  final String day;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(day, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(width: 5),
                  const BoxedIcon(WeatherIcons.cloud),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$maxTemp°',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '/ $minTemp°',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        hasDivider ? const MobileHorizontalDivider() : const SizedBox(height: 10),
      ],
    );
  }
}
