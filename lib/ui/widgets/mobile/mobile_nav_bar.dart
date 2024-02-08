import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/language_selector.dart';
import 'package:weather_app/ui/widgets/theme_switch.dart';
import 'package:weather_app/ui/widgets/units_switch.dart';

class MobileBottomNavigationBar extends StatelessWidget {
  const MobileBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      height: 65,
      padding: EdgeInsets.zero,
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
          ),
        ),
        height: 30.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider.value(
                        value: viewModel,
                        child: const SettingsBottomSheet(),
                      );
                    });
              },
            ),
            IconButton(
              icon: Icon(Icons.menu_rounded, size: 30, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () {
                viewModel.onMenuClicked();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
      ),
      height: 320,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          const SettingsParameter(
            title: 'Units',
            child: UnitsSwitch(),
          ),
          const SizedBox(height: 10),
          const SettingsParameter(title: 'Theme', child: ThemeSwitch()),
          const SizedBox(height: 10),
          const SettingsParameter(title: 'Language', child: LanguageSelector()),
        ],
      ),
    );
  }
}

class SettingsParameter extends StatelessWidget {
  const SettingsParameter({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          child,
        ],
      ),
    );
  }
}
