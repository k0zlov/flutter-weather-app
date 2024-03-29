import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/home/versions/mobile_screen.dart';
import 'package:weather_app/ui/home/versions/restricted_screen.dart';
import 'package:weather_app/ui/home/versions/wide_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(context),
      child: const SafeArea(child: HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1150) {
                return const WideScreenVersion();
              } else if (constraints.maxWidth > 915) {
                return const RestrictedScreenVersion();
              } else {
                return const MobileScreenVersion();
              }
            },
          );
  }
}