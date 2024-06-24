import 'package:flutter/material.dart';
import 'package:telze/services/steps_service.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsWidget extends StatefulWidget {
  const StepsWidget({super.key});

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  final StepsService _stepsService = StepsService();
  int _currentSteps = 0;
  bool _showPermissionDeniedMessage = false;

  @override
  void initState() {
    super.initState();
    _initSteps();
    _checkPermissionsAndStartListening();
  }

  Future<void> _initSteps() async {
    _currentSteps = await _stepsService.getStepsToday();
    setState(() {});
  }

  void _checkPermissionsAndStartListening() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      await _requestPermissionAndHandleResult();
    } else {
      _startListening();
    }
  }

  Future<void> _requestPermissionAndHandleResult() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _startListening();
    } else {
      setState(() {
        _showPermissionDeniedMessage = true;
      });
    }
  }

  void _startListening() {
    _stepsService.startListening((steps) {
      setState(() {
        _currentSteps = steps;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showPermissionDeniedMessage ? null : AppBar(
        title: const Text('Stappenteller'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_showPermissionDeniedMessage) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Error: Geef ons aub toegang tot uw activiteiten',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Stappen van vandaag:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_currentSteps',
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }
}
