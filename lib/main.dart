import 'package:flutter/material.dart';
import 'package:telze/pages/telze_home_page.dart';

void main() {
  runApp(const TelzeApp());
}

class TelzeApp extends StatelessWidget {
  const TelzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelzeHomePage(),
    );
  }
}
