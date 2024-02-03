import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/home/versions/restricted_screen.dart';
import 'package:weather_app/ui/home/versions/wide_screen.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1150) {
              return const WideScreenVersion();
            } else {
              return const RestrictedScreen();
            }
          },
        ),
      ),
    );
  }
}
