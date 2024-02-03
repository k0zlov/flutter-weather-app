import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/application/application_view_model.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationViewModel applicationViewModel = context.read<ApplicationViewModel>();
    return IconButton(
      padding: const EdgeInsets.all(10),
      onPressed: () => applicationViewModel.switchTheme(),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      icon: const Icon(Icons.sunny),
    );
  }
}
