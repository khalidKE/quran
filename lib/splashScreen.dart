import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quran/OnBoardingScreen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()=> 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BoardScreen()), 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              'quran',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/islamic.png'),
          )
        ],
      ),
    ));
  }
}
