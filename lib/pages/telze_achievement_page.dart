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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            const Text(
              'Prestaties',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  final isUnlocked = currentSteps >= achievement.stepsRequired;

                  return AchievementWidget(
                    achievement: achievement,
                    isUnlocked: isUnlocked,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
