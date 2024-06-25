import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final String description;
  final int stepsRequired;

  const Achievement({
    required this.title,
    required this.description,
    required this.stepsRequired,
  });
}

class AchievementWidget extends StatelessWidget {
  final Achievement achievement;
  final bool isUnlocked;
  final double fontSize;

  const AchievementWidget({
    super.key,
    required this.achievement,
    required this.isUnlocked,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isUnlocked ? Icons.emoji_events : Icons.lock,
        color: isUnlocked ? Colors.amber : Colors.grey,
      ),
      title: Text(
        achievement.title,
        style: TextStyle(
          fontSize: fontSize,
          color: isUnlocked ? Colors.black : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        achievement.description,
        style: TextStyle(
          fontSize: fontSize - 6,
        ),
      ),
    );
  }
}
