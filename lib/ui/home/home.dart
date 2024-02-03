import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/language_selector.dart';
import 'package:weather_app/ui/widgets/search_field.dart';
import 'package:weather_app/ui/widgets/theme_switch.dart';
import 'package:weather_app/ui/widgets/units_switch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const SafeArea(child: HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String currentDate = 'Mon, 15 May, 2023';

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: Column(
          children: [
            AppBar(),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Mon, 15 May, 2023', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(
          child: Row(
            children: [
              SearchField(),
              SizedBox(width: 20),
              LanguageSelector(),
              SizedBox(width: 20),
              ThemeSwitch(),
              SizedBox(width: 20),
              UnitsSwitch(),
            ],
          ),
        ),
      ],
    );
  }
}
