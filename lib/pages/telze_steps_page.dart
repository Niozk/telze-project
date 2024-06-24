import 'package:flutter/material.dart';
import 'package:telze/components/steps_widget.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: StepsWidget(),
      ),
    );
  }
}
