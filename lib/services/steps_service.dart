import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsService {
  Stream<StepCount>? _stepCountStream;
  int _stepsToday = 0;

  void startListening(Function(int) onUpdate) {
    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream!.listen((StepCount? event) {
      if (event != null) {
        _updateSteps(event.steps);
        onUpdate(_stepsToday);
      }
    });

    _fetchSavedSteps();
  }

  void _updateSteps(int steps) async {
    _stepsToday = steps;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps_today', _stepsToday);
    print('Updated steps: $_stepsToday');
  }

  void _fetchSavedSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedSteps = prefs.getInt('steps_today') ?? 0;
    _stepsToday = savedSteps;
  }

  Future<int> getStepsToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _stepsToday = prefs.getInt('steps_today') ?? 0;
    return _stepsToday;
  }
}
