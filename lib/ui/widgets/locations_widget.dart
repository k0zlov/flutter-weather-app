import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/home/home_state.dart';
import 'package:weather_app/ui/home/home_view_model.dart';
import 'package:weather_app/ui/widgets/content_container.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationsListWidget extends StatelessWidget {
  const LocationsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    final HomePageState state = context.select((HomeViewModel viewModel) => viewModel.state);

    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: AddLocationWidget(),
          ),
          ...state.locations.map((location) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LocationWidget(
                onTap: () => viewModel.changeCurrentLocation(id: location.id),
                isSelected: location.id == state.currentLocation,
                icon: location.currentWeather.icon,
                cityName: location.geocoding.city,
                countryName: location.geocoding.country,
                minTemp: location.weatherForecastList[0].minTemperature,
                maxTemp: location.weatherForecastList[0].maxTemperature,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    super.key,
    required this.cityName,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    required this.countryName,
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final String cityName;
  final String countryName;
  final IconData icon;
  final int maxTemp;
  final int minTemp;
  final void Function() onTap;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ContentContainer(
                  width: 200,
                  height: 200,
                  backgroundColor: widget.isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                      : isHovered
                          ? Theme.of(context).colorScheme.onSurface.withOpacity(0.2)
                          : null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.cityName, style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 1),
                        Text(widget.countryName, style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${widget.maxTemp}°', style: Theme.of(context).textTheme.headlineLarge),
                            const SizedBox(width: 2),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('/ ${widget.minTemp}°', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 60,
                width: 60,
                child: isHovered
                    ? Icon(Icons.cancel, size: 50, color: Theme.of(context).colorScheme.onPrimary)
                    : BoxedIcon(
                        widget.icon,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddLocationWidget extends StatefulWidget {
  const AddLocationWidget({super.key});

  @override
  State<AddLocationWidget> createState() => _AddLocationWidgetState();
}

class _AddLocationWidgetState extends State<AddLocationWidget> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _iconController.repeat();
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        _iconController.stop();
        _iconController.reset();
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: DottedBorder(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 2,
                dashPattern: const [10, 5],
                customPath: (size) {
                  return Path()
                    ..moveTo(20, 0)
                    ..lineTo(size.width - 20, 0)
                    ..arcToPoint(Offset(size.width, 20), radius: const Radius.circular(20))
                    ..lineTo(size.width, size.height - 20)
                    ..arcToPoint(Offset(size.width - 20, size.height), radius: const Radius.circular(20))
                    ..lineTo(20, size.height)
                    ..arcToPoint(Offset(0, size.height - 20), radius: const Radius.circular(20))
                    ..lineTo(0, 20)
                    ..arcToPoint(const Offset(20, 0), radius: const Radius.circular(20));
                },
                radius: const Radius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(
                    color: isHovered ? Theme.of(context).colorScheme.onSurface.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Add Location', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Add new cities you are interested in',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              height: isHovered ? 65 : 60,
              width: isHovered ? 65 : 60,
              child: Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  size: isHovered ? 40 : 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                  progress: _iconController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
