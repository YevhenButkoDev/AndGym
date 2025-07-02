import 'package:flutter/material.dart';
import 'package:module_gym/components/MainAppBar.dart';
import 'package:module_gym/components/BottomNavBar.dart';
import 'package:module_gym/pages/redesign/PodsPage.dart';
import 'package:module_gym/theme/Colours.dart';

import 'HomePage.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    PodsPage(),
    const Center(child: Text('Bookings Page', style: TextStyle(fontSize: 22))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 22))),
  ];

  final List<String> _titles = const [
    'Home', 'Pods', 'Booking', 'Profile'
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).raisinBlack,
      appBar: MainAppBar(title: _titles[_selectedIndex]),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}