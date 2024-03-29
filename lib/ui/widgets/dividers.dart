import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Divider(thickness: 2, color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.6)),
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 2,
        height: 10,
        child: ColoredBox(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
