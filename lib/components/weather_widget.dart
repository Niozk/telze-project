import 'package:flutter/material.dart';
import 'package:telze/services/weather_service.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<Weather> futureWeather;
  final loc.Location location = loc.Location();
  final Completer<Weather> _completer = Completer<Weather>();

  TextStyle weatherTextStyle(BuildContext context, {bool bold = false}) {
    double fontSize = MediaQuery.of(context).size.width < 700 ? 20 : 32;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  String getWalkMessage(Weather weather) {
    if (weather.temperature > 0) {
      if (weather.main.toLowerCase() == 'rain') {
        return "Je kan beter binnen blijven, het regent.";
      } else {
        return "Wat een mooie dag om te gaan lopen!";
      }
    } else {
      return "Je kan voor nu beter binnen blijven...";
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = _completer.future;
    _requestPermissionAndGetLocation();
  }

  Future<void> _requestPermissionAndGetLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        _completer.completeError('Geef ons aub toegang tot uw locatie');
        return;
      }
    }

    locationData = await location.getLocation();
    try {
      Weather weather = await WeatherService().fetchWeatherByLocation(locationData.latitude!, locationData.longitude!);
      _completer.complete(weather);
    } catch (error) {
      _completer.completeError('Iets ging verkeerd, probeer het later opnieuw');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 700;

        return FutureBuilder<Weather>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final weather = snapshot.data!;
              String walkMessage = getWalkMessage(weather);

              return Container(
                margin: isWideScreen
                    ? const EdgeInsets.symmetric(vertical: 80, horizontal: 100)
                    : const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_city,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width < 700 ? 20 : 32, // Adjust size based on screen width
                          ),
                          const SizedBox(width: 4),
                          Text(weather.city, style: weatherTextStyle(context, bold: true), textAlign: TextAlign.center),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(weather.description, style: weatherTextStyle(context), textAlign: TextAlign.center,),
                      Text('${weather.temperature.toStringAsFixed(1)}°C', style: weatherTextStyle(context), textAlign: TextAlign.center,),
                      Text('Vochtigheid: ${weather.humidity}%', style: weatherTextStyle(context), textAlign: TextAlign.center,),
                      const SizedBox(height: 16),
                      Text(walkMessage, style: weatherTextStyle(context), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
