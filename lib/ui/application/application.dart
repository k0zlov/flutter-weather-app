import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/theme/theme_data.dart';
import 'package:weather_app/ui/application/application_state.dart';
import 'package:weather_app/ui/application/application_view_model.dart';
import 'package:weather_app/ui/home/home.dart';

class WeatherApplication extends StatelessWidget {
  const WeatherApplication({super.key});

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => ApplicationViewModel(),
      child: const WeatherApplication(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationState applicationState = context.select((ApplicationViewModel viewModel) => viewModel.state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: applicationState.isDarkTheme ? ApplicationTheme.darkThemeData : ApplicationTheme.lightThemeData,
      home: HomePage.render(),
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
