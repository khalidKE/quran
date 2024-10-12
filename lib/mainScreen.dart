import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/homeScreen.dart';
import 'package:quran/prayerScreen.dart';
import 'package:quran/qariScreen.dart';
import 'package:quran/quranScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> _widgetList = [
    const HomeScreen(),
    const QuranScreen(),
    const QariListScreen(),
    const PrayerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetList[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          items: _buildTabItems(),
          initialActiveIndex: 0,
          onTap: _updateIndex,
          backgroundColor: Constants.kPrimary,
          activeColor: Colors.white,
          color: Colors.grey[300],
        ),
      ),
    );
  }

  //  method to build tab items
  List<TabItem> _buildTabItems() {
    return [
      _createTabItem('assets/home.png', 'Home'),
      _createTabItem('assets/holyQuran.png', 'Quran'),
      _createTabItem('assets/audio.png', 'Audio'),
      _createTabItem('assets/mosque.png', 'Prayer'),
    ];
  }

  //  method to create a tab item with dynamic icon and title
  TabItem _createTabItem(String iconPath, String title) {
    return TabItem(
      icon: Image.asset(iconPath, color: Colors.white),
      activeIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.scale(
          scale: 0.7,
          child: Image.asset(iconPath, color: Colors.black),
        ),
      ),
      title: title,
    );
  }

  // Updates the index when a tab is tapped
  void _updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
