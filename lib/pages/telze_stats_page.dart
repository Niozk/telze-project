import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Future<int> getStepsTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('steps_total') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: getStepsTotal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final int stepsTotal = snapshot.data!;
            final double kilometers = stepsTotal / 1400;
            final double hoursWalked = stepsTotal / 6000;
            final double caloriesBurned = stepsTotal * 40 / 1000;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 40),
                  const Text(
                    'Statistieken',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text('Totale stappen: $stepsTotal', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('Afstand in kilometers: ${kilometers.toStringAsFixed(2)} km', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('Tijd gewandeld: ${hoursWalked.toStringAsFixed(2)} uur', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('Verbrande calorieën: ${caloriesBurned.toStringAsFixed(2)} kcal', style: const TextStyle(fontSize: 24)),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Geen data beschikbaar'));
          }
        },
      ),
    );
  }
}
