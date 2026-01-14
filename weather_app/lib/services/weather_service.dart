import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather.dart';

class WeatherService {
  static final String apiKey =
      dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather> getWeather(String cityName) async {
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing.');
    }

    final Uri url = Uri.parse(
      '$baseUrl?q=${Uri.encodeComponent(cityName)}&appid=$apiKey&units=metric',
    );

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API Key.');
    } else if (response.statusCode == 404) {
      throw Exception('City not found.');
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }
}
