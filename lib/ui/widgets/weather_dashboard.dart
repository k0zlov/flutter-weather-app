import 'package:flutter/material.dart';

class WeatherDashboardWidget extends StatelessWidget {
  const WeatherDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> items = List.generate(24, (index) => ['$index°', Icons.cloud, '$index:00']);

    return Column(
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.displayMedium!,
          child: const DayStatistics(),
        ),
        Expanded(
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
    );
  }
}

class HourStatisticsBox extends StatefulWidget {
  const HourStatisticsBox({super.key, required this.temperature, required this.time, required this.icon});

  final String temperature;
  final String time;
  final IconData icon;

  @override
  State<HourStatisticsBox> createState() => _HourStatisticsBoxState();
}

class _HourStatisticsBoxState extends State<HourStatisticsBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: Container(
        decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Theme.of(context).colorScheme.onPrimary, offset: const Offset(-2, 1), blurRadius: 5)
            ]),
        width: 68,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 14,
              ),
          child: Column(
            children: [
              Text(widget.time),
              const SizedBox(height: 5),
              Icon(widget.icon, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 5),
              Text(widget.temperature),
            ],
          ),
        ),
      ),
    );
  }
}

class DayStatistics extends StatelessWidget {
  const DayStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.cloud, size: 150),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Berlin'), Text('Germany', style: Theme.of(context).textTheme.labelLarge)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('+20°'), Text('Temperature', style: Theme.of(context).textTheme.labelLarge)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('24%'), Text('Humidity', style: Theme.of(context).textTheme.labelLarge)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [const Text('13'), Text('km/h', style: Theme.of(context).textTheme.labelLarge)],
            ),
            Text('Wind speed', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
      ],
    );
  }
}
