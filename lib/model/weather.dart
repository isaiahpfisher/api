class Weather {
  late final int windSpeed;
  late final int windDirection;
  late final int humidity;
  late final int temperature;
  late final int feelsLikeTemperature;
  late final int uvIndex;
  late final int rainRate;
  final DateTime lastUpdated;

  // Time Estimate: 1hr 15min
  // Actual: 1hr 30min

  Weather.fromWeatherlink(Map<String, dynamic> data)
    : lastUpdated = DateTime.now() {
    windSpeed = data['windSpeed'];
    windDirection = data['windDirection'];
    humidity = data['humidity'];
    uvIndex = data['uvIndex'];
    temperature = data['temperature'];
    rainRate = data['rainRate'];
    feelsLikeTemperature = data['feels_like'];
  }
}
