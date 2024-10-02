import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'quran',
      theme: ThemeData(
        primarySwatch: Constants.kSwatchColor,
        primaryColor: Constants.kprimary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}
