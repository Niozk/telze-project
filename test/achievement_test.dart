import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telze/pages/telze_achievement_page.dart';

void main() {
  group('Achievement Page Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'steps_total': 0});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('Alles hoort gelocked te blijven', (WidgetTester tester) async {
      await prefs.setInt('steps_total', 0);
      await tester.pumpWidget(const MaterialApp(
        home: AchievementPage(currentSteps: 0),
      ));

      expect(find.byIcon(Icons.lock), findsNWidgets(3));
    });

    testWidgets('Eerste achievement moet worden geunlocked', (WidgetTester tester) async {
      await prefs.setInt('steps_total', 1500);
      await tester.pumpWidget(const MaterialApp(
        home: AchievementPage(currentSteps: 1500),
      ));

      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsNWidgets(2));
    });

    testWidgets('Alle achievements moeten geunlocked zijn', (WidgetTester tester) async {
      await prefs.setInt('steps_total', 11000);
      await tester.pumpWidget(const MaterialApp(
        home: AchievementPage(currentSteps: 11000),
      ));

      expect(find.byIcon(Icons.emoji_events), findsNWidgets(3));
    });
  });
}
