import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';

class WeatherChartWidget extends StatelessWidget {
  const WeatherChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const ChartDataPicker(),
          ],
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Chart(),
          ),
        ),
      ],
    );
  }
}

class ChartDataPicker extends StatefulWidget {
  const ChartDataPicker({super.key});

  @override
  State<ChartDataPicker> createState() => _ChartDataPickerState();
}

class _ChartDataPickerState extends State<ChartDataPicker> {
  bool isHovered = false;
  bool isHumidity = true;

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
        onTap: () => setState(() {
          isHumidity = !isHumidity;
        }),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isHovered
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.25)
                : Theme.of(context).colorScheme.secondary,
          ),
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: isHumidity ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  width: 100,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Humidity',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: isHumidity
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Pressure',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: !isHumidity
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> items = List.generate(
      30 * 12 ~/ 7,
          (index) => FlSpot(
        index.toDouble(),
        Random().nextInt(101).toDouble(),
      ),
    );

    final int currentMonth = DateTime.now().month;
    final List<String> currentMonthsList = [];

    for (int i = currentMonth; i < monthsList.length; i++) {
      currentMonthsList.add(monthsList[i]);
    }

    for (int i = 0; i < currentMonth; i++) {
      currentMonthsList.add(monthsList[i]);
    }

    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
          curveSmoothness: 0.2,
          shadow: const BoxShadow(offset: Offset(1, 1), color: Colors.grey, blurRadius: 6),
          spots: items,
          isCurved: true,
          color: Theme.of(context).colorScheme.primary,
          barWidth: 4,
          isStrokeCapRound: true,
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.2),
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
            Theme.of(context).colorScheme.primary.withOpacity(0.6),
            Theme.of(context).colorScheme.primary,
          ]),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      gridData: const FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          drawBelowEverything: false,
          sideTitles: SideTitles(
            getTitlesWidget: (title, _) => Text(
              title < 0 || title > 100 ? '' : '$title%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            interval: 10,
            reservedSize: 45,
            showTitles: true,
          ),
        ),
        bottomTitles: AxisTitles(
          drawBelowEverything: false,
          sideTitles: SideTitles(
            getTitlesWidget: (title, _) {
              final intValue = title.toInt();
              if (intValue % 4 == 0 && intValue ~/ 4 < currentMonthsList.length) {
                return Container(
                  margin: const EdgeInsets.only(left: 80),
                  child: Text(
                    currentMonthsList[title.toInt() ~/ 4],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
            interval: 4,
            showTitles: true,
            reservedSize: 30,
          ),
        ),
        topTitles: const AxisTitles(drawBelowEverything: false, sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(drawBelowEverything: false, sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: -1,
      maxX: 12 * 30 / 7,
      minY: -10,
      maxY: 110,
    ));
  }
}
