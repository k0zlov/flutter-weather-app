import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

abstract class IconConverter {
  static IconData getIconDataFromIconId({required String id}) {
    final String code = id.substring(0, 2);
    final bool isNightIcon = id.substring(2) == 'n';

    switch(code) {
      case '01': return isNightIcon ? WeatherIcons.night_clear : WeatherIcons.day_sunny;
      case '02': return isNightIcon ? WeatherIcons.night_alt_partly_cloudy : WeatherIcons.day_sunny_overcast;
      case '03': return isNightIcon ? WeatherIcons.night_cloudy : WeatherIcons.day_cloudy;
      case '04': return WeatherIcons.cloudy;
      case '09': return WeatherIcons.showers;
      case '10': return isNightIcon ? WeatherIcons.night_alt_showers : WeatherIcons.day_showers;
      case '11': return isNightIcon ? WeatherIcons.night_thunderstorm : WeatherIcons.day_thunderstorm;
      case '13': return isNightIcon ? WeatherIcons.night_snow : WeatherIcons.day_snow;
      case '50': return isNightIcon ? WeatherIcons.night_fog : WeatherIcons.day_fog;
      default: return WeatherIcons.na;
    }
  }
}
