import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/mobile/mobile_dividers.dart';

class WideAppBar extends StatelessWidget {
  const WideAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Mon, 13 May',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4.0),
        Text(
          'Kyiv',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 2.0),
        const Icon(
          Icons.cloud,
          size: 130.0,
        ),
        const SizedBox(width: 2.0),
        Text(
          'Cloudy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '23°',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 50),
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('H:11'),
              MobileVerticalDivider(),
              Text('L:26'),
            ],
          ),
        )
      ],
    );
  }
}

class CollapsedAppBar extends StatelessWidget {
  const CollapsedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud,
              size: 130.0,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mon, 13 May',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Kyiv',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleSmall!,
              child: const Row(
                children: [
                  Text('23°'),
                  MobileVerticalDivider(),
                  Text('Cloudy'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
