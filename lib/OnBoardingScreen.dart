import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran/constants.dart';
import 'package:quran/mainScreen.dart';

// on boarding
class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: IntroductionScreen(
            pages: [
              PageViewModel(
                title: "Read quran",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Customize your reading view",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset(
                  'assets/quran.png',
                  fit: BoxFit.fitHeight,
                )),
              ),
              PageViewModel(
                title: "Prayer Alerts",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Choose your adhan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset(
                  'assets/prayer.png',
                  fit: BoxFit.fitHeight,
                )),
              ),
              PageViewModel(
                title: "Build Better Habits",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Make Islamic practices part of your life",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset(
                  'assets/zakat.png',
                  fit: BoxFit.fitHeight,
                )),
              )
            ],
            showNextButton: true,
            next: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            done: const Text("Done",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.black)),
            onDone: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Mainscreen(),
                ),
              );
            },
            onSkip: () {},
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Constants.kprimary,
              color: Colors.grey,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          )),
    );
  }
}
