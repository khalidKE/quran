import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/JuzScreen.dart';
import 'package:quran/Sajda.dart';
import 'package:quran/SajdaTile.dart';
import 'package:quran/Surah.dart';
import 'package:quran/SurahCustomTile.dart';
import 'package:quran/constants.dart';
import 'package:quran/surah_details.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quran'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Surah'),
                Tab(text: 'Sajda'),
                Tab(text: 'Juz'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildSurahTab(),
              _buildSajdaTab(),
              _buildJuzTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurahTab() {
    return FutureBuilder<List<Surah>>(
      future: apiServices.getSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading Surah'));
        }
        final surah = snapshot.data ?? [];
        return ListView.builder(
          itemCount: surah.length,
          itemBuilder: (context, index) => SurahCustomListTile(
            surah: surah[index],
            context: context,
            ontap: () {
              setState(() {
                Constants.surahIndex = (index + 1);
              });
              Navigator.pushNamed(context, Surahdetail.id);
            },
          ),
        );
      },
    );
  }

  Widget _buildSajdaTab() {
    return FutureBuilder<SajdaList>(
      future: apiServices.getSajda(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading Sajda'));
        }
        final sajdaAyahs = snapshot.data?.sajdaAyahs ?? [];
        return ListView.builder(
          itemCount: sajdaAyahs.length,
          itemBuilder: (context, index) => SajdaCustomTile(
            sajdaAyahs[index],
            context,
          ),
        );
      },
    );
  }

  Widget _buildJuzTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(19),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        childAspectRatio: 1.0, 
        mainAxisSpacing: 0, 
        crossAxisSpacing: 0, 
      ),
      itemCount: 30,
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
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
