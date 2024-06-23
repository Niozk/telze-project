import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class Weather {
  final String city;
  final String description;
  final double temperature;
  final int humidity;
  final String main;

  Weather({
    required this.city,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.main,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
      city: city,
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      main: json['weather'][0]['main'],
    );
  }
}

class WeatherService {
  static const String _apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = 'e4f5d4086edc70493ee3c27099fff3d2';

  Future<Weather> fetchWeatherByLocation(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    String city = placemarks.first.locality ?? 'Unknown location';

    final response = await http.get(Uri.parse('$_apiUrl?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric&lang=nl'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body), city);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
