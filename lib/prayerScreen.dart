import 'package:flutter/material.dart';

class Prayerscreen extends StatefulWidget {
  const Prayerscreen({super.key});

  @override
  State<Prayerscreen> createState() => _PrayerscreenState();
}

class _PrayerscreenState extends State<Prayerscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text('prayer'),
      ),
    ));
  }
}
