import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/weather_dashboard.dart';

class MobileScreenVersion extends StatelessWidget {
  const MobileScreenVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              scrolledUnderElevation: 0,
              pinned: true,
              collapsedHeight: 150,
              expandedHeight: 400,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxHeight < 350) {
                  return const CollapsedAppBar();
                } else {
                  return const WideAppBar();
                }
              }),
            )
          ];
        },
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Column(
              children: [
                MobileHourlyStatistics(),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileHourlyStatistics extends StatelessWidget {
  const MobileHourlyStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> items = List.generate(24, (index) => ['$index°', Icons.cloud, '$index:00']);
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(4),
        // height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              child: Text(
                'Some weather description',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Divider(thickness: 2, color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.6)),
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
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
        ),
      ),
    );
  }
}

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
              CustomVerticalDivider(),
              Text('L:26'),
            ],
          ),
        )
      ],
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
              color: Colors.white,
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
                  CustomVerticalDivider(),
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
