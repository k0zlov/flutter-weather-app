import 'package:flutter/material.dart';

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> items = List.generate(
      5,
      (index) => [Icons.cloud, '${index + 5}°', '${index - 5}°', '${index + 3}', 'May, Wed'],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Forecast', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              ...items.map(
                (e) => ForecastDayWidget(
                  icon: e[0],
                  minTemp: e[2],
                  maxTemp: e[1],
                  day: e[3],
                  date: e[4],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ForecastDayWidget extends StatefulWidget {
  const ForecastDayWidget({
    super.key,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
    required this.day,
    required this.date,
  });

  final IconData icon;
  final String minTemp;
  final String maxTemp;
  final String day;
  final String date;

  @override
  State<ForecastDayWidget> createState() => _ForecastDayWidgetState();
}

class _ForecastDayWidgetState extends State<ForecastDayWidget> {
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
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isHovered
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                : Theme.of(context).colorScheme.secondary,
          ),
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: const EdgeInsets.all(12),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineLarge!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(widget.icon, size: 40),
                    const SizedBox(width: 12),
                    Text(widget.maxTemp),
                    const SizedBox(width: 2),
                    Text(
                      '/ ${widget.minTemp}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.day),
                    const SizedBox(width: 2),
                    Text(
                      widget.date,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
