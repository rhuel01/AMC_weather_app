import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/weather.dart';

void main() {
  group('Weather Model Test', () {
    test('should create a Weather instance from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'name': 'Manila',
        'main': {
          'temp': 30.5,
          'humidity': 80,
        },
        'weather': [
          {'main': 'Clouds'}
        ],
        'wind': {
          'speed': 5.5,
        }
      };

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.city, 'Manila');
      expect(weather.temperature, 30.5);
      expect(weather.description, 'Clouds');
      expect(weather.humidity, 80);
      expect(weather.windSpeed, 5.5);
    });

    test('should use default values when JSON is missing fields', () {
      // Arrange
      final Map<String, dynamic> json = {
        'main': {
          'temp': 25.0,
          'humidity': 60,
        },
        'weather': [
          {'main': 'Clear'}
        ],
        'wind': {
          'speed': 2.0,
        }
      };

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.city, 'Unknown');
      expect(weather.temperature, 25.0);
    });
  });
}