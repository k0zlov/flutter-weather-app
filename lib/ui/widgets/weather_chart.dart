import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeatherChartWidget extends StatelessWidget {
  const WeatherChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> items = List.generate(
      30 * 12 ~/ 7,
      (index) => FlSpot(
        index.toDouble(),
        Random().nextInt(101).toDouble(),
      ),
    );
    const List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
    final DateTime currentDate = DateTime.now();
    final List<Color> gradientColors = currentDate.month <= 4
        ? [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ]
        : currentDate.month <= 8
            ? [
                Theme.of(context).colorScheme.primary.withOpacity(0.4),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.4),
              ]
            : [
                Theme.of(context).colorScheme.primary.withOpacity(0.4),
                Theme.of(context).colorScheme.primary.withOpacity(0.4),
                Theme.of(context).colorScheme.primary,
              ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: LineChart(LineChartData(
              lineBarsData: [
                LineChartBarData(
                  curveSmoothness: 0.2,
                  shadow: const BoxShadow(
                    offset: Offset(1, 1),
                    color: Colors.grey,
                    blurRadius: 6
                  ),
                  spots: items,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  gradient: LinearGradient(colors: gradientColors),
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
                      if (intValue % 4 == 0 && intValue ~/ 4 < months.length) {
                        return Container(
                          margin: const EdgeInsets.only(left: 80),
                          child: Text(
                            months[title.toInt() ~/ 4],
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
            )),
          ),
        ),
      ],
    );
  }
}
