import 'package:flutter/material.dart';

class UnitsSwitch extends StatefulWidget {
  const UnitsSwitch({super.key, required this.isFahrenheit, required this.onChange});

  final bool isFahrenheit;
  final void Function() onChange;

  @override
  State<UnitsSwitch> createState() => _UnitsSwitchState();
}

class _UnitsSwitchState extends State<UnitsSwitch> {
  bool isHovered = false;
  late bool isFahrenheit;

  @override
  void initState() {
    super.initState();
    isFahrenheit = widget.isFahrenheit;
  }

  void switchUnits() {
    widget.onChange();
    setState(() {
      isFahrenheit = !isFahrenheit;
    });
  }

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
        onTap: () => switchUnits(),
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
                  alignment: isFahrenheit ? Alignment.centerRight : Alignment.centerLeft,
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
                                color: isFahrenheit
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
                                color: isFahrenheit
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
