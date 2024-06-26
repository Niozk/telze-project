import 'package:flutter/material.dart';
import 'package:telze/pages/telze_weather_page.dart';
import 'package:telze/pages/telze_steps_page.dart';
import 'package:telze/pages/telze_stats_page.dart';
import 'package:telze/pages/telze_achievement_page.dart';
import 'package:telze/services/steps_service.dart';

class TelzeHomePage extends StatefulWidget {
  const TelzeHomePage({super.key});

  @override
  State<TelzeHomePage> createState() => _TelzeHomePageState();
}

class _TelzeHomePageState extends State<TelzeHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  int _currentSteps = 0;

  final StepsService _stepsService = StepsService();

  @override
  void initState() {
    super.initState();
    _initSteps();
  }

  Future<void> _initSteps() async {
    _currentSteps = await _stepsService.getStepsTotal();
    setState(() {});
  }

  List<Widget> get _pages => <Widget>[
    const WeatherPage(),
    const StepsPage(),
    const StatsPage(),
    AchievementPage(currentSteps: _currentSteps),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telze',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hiking),
            label: 'Stappen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistieken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech),
            label: 'Prestaties',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
