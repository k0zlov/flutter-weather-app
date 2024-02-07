import 'package:flutter/material.dart';

import 'dividers.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.width, required this.height, required this.child});

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }
}

class NamedContentContainer extends StatelessWidget {
  const NamedContentContainer({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.icon,
    required this.child,
  });

  final double width;
  final double height;
  final String name;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      width: width,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                const CustomVerticalDivider(),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      ),
                ),
              ],
            ),
          ),
          const CustomHorizontalDivider(),
          child
        ],
      ),
    );
  }
}
