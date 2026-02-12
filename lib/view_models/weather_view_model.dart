import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../model/weather.dart';
import '../services/weatherlink.dart';

class WeatherViewModel extends ChangeNotifier {
  late Weather _weatherData;
  final _weatherlinkData = Weatherlink();

  bool isLoading = true;

  IconData get icon {
    if (_weatherData.uvIndex > 5) {
      return MdiIcons.weatherSunny;
    } else if (_weatherData.rainRate > 0) {
      return MdiIcons.weatherRainy;
    }

    return MdiIcons.weatherCloudy;
  }

  int get currentTemp {
    return _weatherData.temperature;
  }

  int get feelsLike {
    return _weatherData.feelsLikeTemperature;
  }

  String get windDirection {
    if (_weatherData.windDirection < 23) {
      return 'N';
    } else if (_weatherData.windDirection < 68) {
      return 'NE';
    } else if (_weatherData.windDirection < 113) {
      return 'E';
    } else if (_weatherData.windDirection < 158) {
      return 'SE';
    } else if (_weatherData.windDirection < 203) {
      return 'S';
    } else if (_weatherData.windDirection < 248) {
      return 'SW';
    } else if (_weatherData.windDirection < 293) {
      return 'W';
    } else if (_weatherData.windDirection < 338) {
      return 'NW';
    } else {
      return 'N';
    }
  }

  int get windSpeed {
    return _weatherData.windSpeed;
  }

  int get humidity {
    return _weatherData.humidity;
  }

  DateTime get lastUpdated {
    return _weatherData.lastUpdated;
  }

  WeatherViewModel() {
    refresh();
  }

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();

    final weatherFuture = _weatherlinkData.getWeather();
    final timingFuture = Future.delayed(const Duration(milliseconds: 800));
    _weatherData = await weatherFuture;

    // for visualization purposes
    await timingFuture;

    isLoading = false;
    notifyListeners();
  }
}
