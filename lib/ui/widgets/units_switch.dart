import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';

class UnitsSwitch extends StatefulWidget {
  const UnitsSwitch({super.key});
  @override
  State<UnitsSwitch> createState() => _UnitsSwitchState();
}

class _UnitsSwitchState extends State<UnitsSwitch> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
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
        onTap: () => viewModel.switchUnits(),
        child: Container(
          height: 45,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isHovered
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.25)
                : Theme.of(context).colorScheme.onBackground,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: state.isFahrenheit ? Alignment.centerRight : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isHovered
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'C°',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: state.isFahrenheit
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'F°',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: state.isFahrenheit
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
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
