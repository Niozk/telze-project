import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:telze/components/weather_widget.dart';
import 'package:telze/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WeatherWidget integration test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    expect(find.byType(WeatherWidget), findsOneWidget);

    expect(find.textContaining('Vochtigheid:'), findsOneWidget);
    expect(find.textContaining('°C'), findsOneWidget);
  });
}
