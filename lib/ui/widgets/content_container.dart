import 'package:flutter/material.dart';

import 'dividers.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.backgroundColor,
  });

  final double width;
  final double height;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor ?? Theme.of(context).colorScheme.onBackground,
          boxShadow: [
            BoxShadow(offset: const Offset(-4, 2), blurRadius: 2, color: Colors.black.withOpacity(0.3)),
          ]),
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
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
