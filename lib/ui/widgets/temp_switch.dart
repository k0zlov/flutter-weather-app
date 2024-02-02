import 'package:flutter/material.dart';

class TemperatureSwitch extends StatefulWidget {
  const TemperatureSwitch({super.key});

  @override
  State<TemperatureSwitch> createState() => _TemperatureSwitchState();
}

class _TemperatureSwitchState extends State<TemperatureSwitch> {
  bool isF = false;

  void change() {
    setState(() {
      isF = !isF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => change(),
      child: Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              AnimatedContainer(
                alignment: isF ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'C',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: isF
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
                        'F',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: isF
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
    );
  }
}
