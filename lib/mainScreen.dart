import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran/audioScreen.dart';
import 'package:quran/constants.dart';
import 'package:quran/homeScreen.dart';
import 'package:quran/prayerScreen.dart';
import 'package:quran/quranScreen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int selectindex = 0;
  final List<Widget> _widgetsList = [
    HomeScreen(),
    Quranscreen(),
    AudioScreen(),
    Prayerscreen()
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
                    icon: Image.asset('assets/holyQuran.png',
                        color: Colors.white),
                    title: 'Quran'),
                TabItem(
                    icon: Image.asset('assets/audio.png', color: Colors.white),
                    title: 'Audio'),
                TabItem(
                    icon: Image.asset('assets/mosque.png', color: Colors.white),
                    title: 'Prayer'),
              ],
              initialActiveIndex: 0,
              onTap: updateIndex,
              backgroundColor: Constants.kprimary,
              activeColor: Constants.kprimary,
              // onTap: (int i) => print('click index=$i'),
            )));
  }

  void updateIndex(index) {
    setState(() {
      selectindex = index;
    });
  }
}
