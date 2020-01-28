import 'package:flutter/material.dart';
import 'package:trackly_app/screens/dashboard_screen.dart';
import 'package:trackly_app/screens/timer_screen.dart';


/// Screen to provide bottomNavigation
class RootScreen extends StatefulWidget {
  final static = "/timer-screen";
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static final GlobalKey _scaffold = GlobalKey();

  int _selectedIndex = 0;
  List<Widget> _screens = [
    TimerScreen(
      scaffold: _scaffold,
    ),
    DashboardScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            title: Text('Timer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            title: Text('Dashboard'),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
