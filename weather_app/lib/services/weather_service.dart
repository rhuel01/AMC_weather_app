import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String apiKey = '36f939b87cfb870764d46172000cf385'; 
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather> getWeather(String cityName) async {
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing.');
    }

    try {
      final Uri url = Uri.parse('$baseUrl?q=${Uri.encodeComponent(cityName)}&appid=$apiKey&units=metric');

      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Weather.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API Key. Keys can take 2 hours to activate.');
      } else if (response.statusCode == 404) {
        throw Exception('City not found.');
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      // On Web, this is often a CORS error.
      throw Exception('Connection error. If on Web, try disabling web security or use a mobile emulator.');
    }
  }
}