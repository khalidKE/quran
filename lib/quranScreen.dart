import 'package:flutter/material.dart';
import 'package:quran/API.dart';
import 'package:quran/Surah.dart';
import 'package:quran/SurahCustomTile.dart';

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
            title: Text('Quran'),
            centerTitle: true,
            bottom: TabBar(tabs: [
              Text(
                'Surah',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Sajda',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Juz',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            FutureBuilder(
                future: apiServices.getSurah(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Surah>> snapshot) {
                  if (snapshot.hasData) {
                    List<Surah>? surah = snapshot.data;
                    return ListView.builder(
                      itemCount: surah!.length,
                      itemBuilder: (context, index) => SurahCustomTile(
                        surah: surah[index],
                        context: context,
                        ontap: () {},
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ])),
    );
  }
}
