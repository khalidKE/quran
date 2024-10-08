import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/JuzScreen.dart';
import 'package:quran/Sajda.dart';
import 'package:quran/SajdaTile.dart';
import 'package:quran/Surah.dart';
import 'package:quran/SurahCustomTile.dart';
import 'package:quran/constants.dart';
import 'package:quran/surah_details.dart';

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
            FutureBuilder(
              future: apiServices.getSurah(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Surah data available'),
                  );
                } else {
                  List<Surah>? surahList = snapshot.data;
                  return ListView.builder(
                    itemCount: surahList!.length,
                    itemBuilder: (context, index) {
                      return SurahCustomTile(
                        surah: surahList[index],
                        context: context,
                        ontap: () {
                          setState(() {
                            Constants.surahIndex = (index + 1);
                          });
                          Navigator.pushNamed(context, SurahDetails.id);
                        },
                      );
                    },
                  );
                }
              },
            ),
            FutureBuilder(
              future: apiServices.getSajda(),
              builder:
                  (BuildContext context, AsyncSnapshot<SajdaList> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.sajdaAyahs.length,
                    itemBuilder: (context, index) {
                      return SajdaCustomTile(
                          snapshot.data!.sajdaAyahs[index], context);
                    },
                  );
                } else {
                  return const Center(child: Text('No Sajda Ayahs available'));
                }
              },
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
