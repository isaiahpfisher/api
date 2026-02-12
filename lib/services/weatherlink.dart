import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather.dart';

class Weatherlink {
  final httpClient = http.Client();

  Future<Weather> getWeather() async {
    final uri = Uri.parse(
      'https://us-central1-oc-weather-25.cloudfunctions.net/weather',
    );

    final httpPayload = await http.get(uri);
    final body = await jsonDecode(httpPayload.body);

    final data = body['sensors'].firstWhere(
      (sensor) => sensor['sensor_type'] == 45,
    )['data'][0];

    return Weather.fromWeatherlink({
      'temperature': data['temp'].toInt(),
      'windSpeed': data['wind_speed_avg_last_10_min'].toInt(),
      'windDirection': data['wind_dir_scalar_avg_last_10_min'].toInt(),
      'humidity': data['hum'].toInt(),
      'uvIndex': data['uv_index'].toInt(),
      'rainRate': data['rain_rate_last_in'].toInt(),
      'feels_like': data['temp'] > 65
          ? data['heat_index'].toInt()
          : data['wind_chill'].toInt(),
    });
  }
}
