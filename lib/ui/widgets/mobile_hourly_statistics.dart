import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile_dividers.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';

class MobileHourlyStatistics extends StatelessWidget {
  const MobileHourlyStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> items = List.generate(24, (index) => ['$index°', Icons.cloud, '$index:00']);
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(4),
        // height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                  const MobileVerticalDivider(),
                  Text(
                    'Hourly forecast',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                  ),
                ],
              ),
            ),
            const MobileHorizontalDivider(),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...items.map(
                    (e) => HourStatisticsBox(
                      temperature: e[0],
                      time: e[2],
                      icon: e[1],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
