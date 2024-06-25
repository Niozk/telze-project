import 'package:flutter/material.dart';
import 'package:telze/components/achievement_widget.dart';

class AchievementPage extends StatelessWidget {
  final int currentSteps;

  const AchievementPage({super.key, required this.currentSteps});

  final List<Achievement> achievements = const [
    Achievement(
      title: 'Eerste stapjes',
      description: 'Loop 1000 stappen.',
      stepsRequired: 1000,
    ),
    Achievement(
      title: 'Wandelaar',
      description: 'Loop 5000 stappen.',
      stepsRequired: 5000,
    ),
    Achievement(
      title: 'Marathon renner',
      description: 'Loop 10000 stappen.',
      stepsRequired: 10000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.width < 700 ? 24 : 40;

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100),
                Text(
                  'Prestaties',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: achievements.map((achievement) {
                        final isUnlocked = currentSteps >= achievement.stepsRequired;
                        return AchievementWidget(
                          achievement: achievement,
                          isUnlocked: isUnlocked,
                          fontSize: MediaQuery.of(context).size.width < 700 ? 20 : 32,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
