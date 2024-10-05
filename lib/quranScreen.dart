import 'package:flutter/material.dart';
import 'package:quran/API.dart';
import 'package:quran/JuzScreen.dart';
import 'package:quran/Surah.dart';
import 'package:quran/SurahCustomTile.dart';
import 'package:quran/constants.dart';

class Quranscreen extends StatefulWidget {
  const Quranscreen({super.key});

  @override
  State<Quranscreen> createState() => _QuranscreenState();
}

class _QuranscreenState extends State<Quranscreen> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quran'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Surah',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  'Sajda',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  'Juz',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Surah Tab
            FutureBuilder(
              future: apiServices.getSurah(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                if (snapshot.hasData) {
                  List<Surah>? surahList = snapshot.data;
                  return ListView.builder(
                    itemCount: surahList!.length,
                    itemBuilder: (context, index) {
                      return SurahCustomTile(
                        surah: surahList[index], // Display Surah names
                        context: context,
                        ontap: () {
                          // You can add an action for tapping on each surah here if needed
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            // Sajda Tab (you can customize this content)
            const Center(
              child: Text("Sajda content goes here."),
            ),

            // Juz Tab
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 30, // Number of Juz in the Quran
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Constants.juzIndex = (index + 1);
                    });
                    Navigator.pushNamed(context, JuzScreen.id);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
