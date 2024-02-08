import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/search_field.dart';

class FullScreenSearchInput extends StatelessWidget {
  const FullScreenSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add your new weather location', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 10),
          const Material(
            elevation: 0,
            color: Colors.transparent,
            child: SearchField(
              width: 500,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
