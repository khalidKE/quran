import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/constants.dart';
import 'package:quran/customTranslation.dart';
import 'package:quran/translations.dart';

class SurahDetails extends StatefulWidget {
  const SurahDetails({super.key});
  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetails> createState() => _SurahDetailsState();
}

class _SurahDetailsState extends State<SurahDetails> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _apiServices.getTranslation(Constants.surahIndex!),
        builder: (BuildContext context,
            AsyncSnapshot<SurahTranslationList> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.translationList.length,
              itemBuilder: (context, index) {
                return TranslationTile(
                  index: index,
                  surahTranslation: snapshot
                      .data!.translationList[index], // Fixed parameter name
                );
              },
            );
          } else {
            return const Center(
              child: Text('Translation Not Found'),
            );
          }
        },
      ),
    );
  }
}
