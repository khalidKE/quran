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
  int selectindex = 0;
  final List<Widget> _widgetsList = [
    const HomeScreen(),
    const QuranScreen(),
    const QariListScreen(),
    const PrayerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _widgetsList[selectindex],
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(
                    icon: Image.asset(
                      'assets/home.png',
                      color: Colors.white,
                    ),
                    title: 'Home'),
                TabItem(
                    icon: Image.asset(
                      'assets/holyQuran.png',
                      color: Colors.white,
                    ),
                    title: 'Quran'),
                TabItem(
                    icon: Image.asset(
                      'assets/audio.png',
                      color: Colors.white,
                    ),
                    title: 'Audio'),
                TabItem(
                    icon: Image.asset(
                      'assets/mosque.png',
                      color: Colors.white,
                    ),
                    title: 'Prayer'),
              ],
              initialActiveIndex: 0, //optional, default as 0
              onTap: updateIndex,
              backgroundColor: Constants.kPrimary,
              activeColor: Constants.kPrimary,
            )));
  }

  void updateIndex(index) {
    setState(() {
      selectindex = index;
    });
  }
}
