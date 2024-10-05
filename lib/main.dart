import 'package:flutter/material.dart';
import 'package:quran/JuzScreen.dart'; // Assuming this is the Juz screen you are using
import 'package:quran/constants.dart'; // Assuming constants contain your theme colors and other settings
import 'package:quran/splashScreen.dart'; // Splash screen at startup

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Constants.kSwatchColor,
        primaryColor: Constants.kprimary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(), // Define the splash screen as the home
      routes: {
        JuzScreen.id: (context) =>
             JuzScreen(), // Define routes for navigation
      },
    );
  }
}