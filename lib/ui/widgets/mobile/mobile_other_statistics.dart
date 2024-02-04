import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';

class MobileOtherStatistics extends StatelessWidget {
  const MobileOtherStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 1,
          child: MobileCustomContainer(title: 'Wind speed', value: '13 km/h', iconData: Icons.wind_power),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: MobileCustomContainer(title: 'Humidity', value: '34%', iconData: Icons.water_drop_rounded),
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
