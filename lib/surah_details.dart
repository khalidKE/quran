// import 'package:flutter/material.dart';
// import 'package:quran/APIServices.dart';
// import 'package:quran/constants.dart';
// import 'package:quran/customTranslation.dart';
// import 'package:quran/translations.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

// enum Translation { english, french, german }

// class SurahDetails extends StatefulWidget {
//   const SurahDetails({super.key});
//   static const String id = 'surahDetail_screen';

//   @override
//   State<SurahDetails> createState() => _SurahDetailsState();
// }

// class _SurahDetailsState extends State<SurahDetails> {
//   ApiServices _apiServices = ApiServices();

//   Translation? _translation = Translation.english;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _apiServices.getTranslation(Constants.surahIndex!,_translation!.index),
//         builder: (BuildContext context,
//             AsyncSnapshot<SurahTranslationList> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             return Padding(
//                 padding: EdgeInsets.only(bottom: 50),
//                 child: ListView.builder(
//                   itemCount: snapshot.data!.translationList.length,
//                   itemBuilder: (context, index) {
//                     return TranslationTile(
//                       index: index,
//                       surahTranslation: snapshot.data!.translationList[index],
//                     );
//                   },
//                 ));
//           } else {
//             return const Center(
//               child: Text('Translation Not Found'),
//             );
//           }
//         },
//       ),
//       bottomSheet: SolidBottomSheet(
//         headerBar: Container(
//           color: Theme.of(context).primaryColor,
//           height: 50,
//           child: Center(
//             child: Text(
//               "Swipe me!",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//         body: Container(
//           color: Colors.white,
//           height: 30,
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   ListTile(
//                     title: const Text('English'),
//                     leading: Radio(
//                         value: Translation.english,
//                         groupValue: _translation,
//                         onChanged: (Translation? value) {
//                           setState(() {
//                             _translation = value;
//                           });
//                         }),
//                   ),
//                   ListTile(
//                     title: const Text('French'),
//                     leading: Radio(
//                         value: Translation.french,
//                         groupValue: _translation,
//                         onChanged: (Translation? value) {
//                           setState(() {
//                             _translation = value;
//                           });
//                         }),
//                   ),ListTile(
//                     title: const Text('German'),
//                     leading: Radio(
//                         value: Translation.german,
//                         groupValue: _translation,
//                         onChanged: (Translation? value) {
//                           setState(() {
//                             _translation = value;
//                           });
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/Surah.dart';
import 'package:quran/constants.dart';
import 'package:quran/customTranslation.dart';
import 'package:quran/translations.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

enum Translation { english, french, german }

class SurahDetails extends StatefulWidget {
  const SurahDetails({super.key});
  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetails> createState() => _SurahDetailsState();
}

class _SurahDetailsState extends State<SurahDetails> {
  ApiServices _apiServices = ApiServices();
  Translation? _translation = Translation.english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _apiServices.getTranslation(
            Constants.surahIndex!, _translation!.index),
        builder: (BuildContext context,
            AsyncSnapshot<SurahTranslationList> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                itemCount: snapshot.data!.translationList.length,
                itemBuilder: (context, index) {
                  return TranslationTile(
                    index: index,
                    surahTranslation: snapshot.data!.translationList[index],
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Translation Not Found'));
          }
        },
      ),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: const Center(
            child: Text(
              "Swipe me!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 150, // Increased height for better usability
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('English'),
                    leading: Radio(
                      value: Translation.english,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('French'),
                    leading: Radio(
                      value: Translation.french,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('German'),
                    leading: Radio(
                      value: Translation.german,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
