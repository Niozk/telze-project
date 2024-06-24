import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsService {
  Stream<StepCount>? _stepCountStream;
  int _stepsTotal = 0;

  void startListening(Function(int) onUpdate) {
    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream!.listen((StepCount? event) {
      if (event != null) {
        _updateSteps(event.steps);
        onUpdate(_stepsTotal);
      }
    });

    _fetchSavedSteps();
  }

  void _updateSteps(int steps) async {
    _stepsTotal = steps;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps_total', _stepsTotal);
  }

  void _fetchSavedSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedSteps = prefs.getInt('steps_total') ?? 0;
    _stepsTotal = savedSteps;
  }

  Future<int> getStepsTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _stepsTotal = prefs.getInt('steps_total') ?? 0;
    return _stepsTotal;
  }
}
