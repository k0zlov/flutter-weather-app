
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/domen/entities/location_entity.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';

class WeatherChartWidget extends StatelessWidget {
  const WeatherChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: WeeklyTextToolTip(),
                )
              ],
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

class WeeklyTextToolTip extends StatelessWidget {
  const WeeklyTextToolTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Each point on the graph is the average data for the week.',
      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSecondary),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Text(
        'weekly',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
      ),
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

  @override
  Widget build(BuildContext context) {
    bool isMobileVersion() {
      return MediaQuery.of(context).size.width < 915;
    }

    final HomeViewModel viewModel = context.read<HomeViewModel>();
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: () => viewModel.switchChartData(),
        child: Container(
          height: isMobileVersion() ? 35 : 50,
          width: isMobileVersion() ? MediaQuery.of(context).size.width : 200,
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
                alignment: state.isPressure ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: isMobileVersion() ? 35 : 50,
                  width: isMobileVersion() ? MediaQuery.of(context).size.width / 2 : 100,
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
                              fontSize: isMobileVersion() ? 12 : 18,
                              color: !state.isPressure
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
                              fontSize: isMobileVersion() ? 12 : 18,
                              color: state.isPressure
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
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    final LocationEntity currentLocation =
        state.locations.singleWhere((location) => location.id == state.currentLocation);

    final List<FlSpot> items = List.generate(
      30 * 12 ~/ 7,
      (index) => FlSpot(
        index.toDouble(),
        state.isPressure
            ? currentLocation.pressureLastYear[index].toDouble()
            : currentLocation.humidityLastYear[index].toDouble(),
      ),
    );

    /// Months logic
    final int currentMonth = DateTime.now().month;
    final List<String> currentMonthsList = [];

    for (int i = currentMonth; i < monthsList.length; i++) {
      currentMonthsList.add(monthsList[i]);
    }

    for (int i = 0; i < currentMonth; i++) {
      currentMonthsList.add(monthsList[i]);
    }

    final String units = state.isPressure ? 'hPa' : '%';

    bool isMobileVersion() {
      return MediaQuery.of(context).size.width < 915;
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
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.secondary,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          showOnTopOfTheChartBoxArea: isMobileVersion(),
          getTooltipItems: (value) {
            return value
                .map((e) => LineTooltipItem(
                    '${(e.x.toInt() - 52) * -1} weeks ago\nAverage: ${e.y}$units',
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        )))
                .toList();
          },
        ),
      ),
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
              title < 0 || title > 100 ? '' : '$title $units',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isMobileVersion() ? 12 : 16),
            ),
            interval: isMobileVersion() ? 20 : 10,
            reservedSize: state.isPressure ? 65 : 45,
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
            interval: isMobileVersion() ? 8 : 4,
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
