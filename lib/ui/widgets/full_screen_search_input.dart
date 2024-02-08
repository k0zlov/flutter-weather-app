import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/search_field.dart';

class FullScreenSearchInput extends StatelessWidget {
  const FullScreenSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SearchField(
        width: 500,
        height: 200,
      ),
    );
  }
}
