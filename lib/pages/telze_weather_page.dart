import 'package:flutter/material.dart';
import 'package:telze/components/weather_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: WeatherWidget(),
      ),
    );
  }
}
