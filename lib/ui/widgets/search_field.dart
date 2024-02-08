import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_view_model.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.width, required this.height});

  // 200 x 45
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
        cursorColor: Theme.of(context).colorScheme.onSurface,
        controller: viewModel.searchController,
        onSubmitted: (_) => viewModel.addLocation(cityName: viewModel.searchController.text),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: IconButton(
            onPressed: () => viewModel.addLocation(cityName: viewModel.searchController.text),
            icon: const Icon(Icons.search),
          ),
          hintText: 'Search city',
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.onBackground,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
