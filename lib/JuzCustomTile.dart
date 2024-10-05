import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:http/http.dart';

// AyaOfTheDay Model
class AyaOfTheDay {
  String arabicText;
  String englishText;
  String surahName;

  AyaOfTheDay({
    required this.arabicText,
    required this.englishText,
    required this.surahName,
  });

  factory AyaOfTheDay.fromJSON(Map<String, dynamic> json) {
    return AyaOfTheDay(
      arabicText: json['data'][0]['text'],
      englishText: json['data'][1]['text'],
      surahName: json['data'][0]['surah']['englishName'],
    );
  }
}

// Surah Model
class Surah {
  String name;
  int ayahCount;

  Surah({required this.name, required this.ayahCount});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      name: json['englishName'],
      ayahCount: json['numberOfAyahs'],
    );
  }
}

// JuzModel Class
class JuzModel {
  List<dynamic> juzAyahs;

  JuzModel({required this.juzAyahs});

  factory JuzModel.fromJson(Map<String, dynamic> json) {
    return JuzModel(
      juzAyahs: json['ayahs'] as List<dynamic>,
    );
  }
}

// JuzCustomTile Widget
class JuzCustomTile extends StatelessWidget {
  final List<dynamic> list;
  final int index;

  JuzCustomTile({required this.list, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(list[index]['text']), // Assuming 'text' contains the Ayah
      subtitle: Text('Ayah Number: ${list[index]['numberInSurah']}'),
    );
  }
}

// ApiServices Class
class ApiServices {
  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  final _random = Random();
  List<Surah> list = [];

  // Method to get Aya of the Day
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    try {
      final url =
          "https://api.alquran.cloud/v1/ayah/${_random.nextInt(6237) + 1}/editions/quran-uthmani,en.asad,en.pickthall";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return AyaOfTheDay.fromJSON(json.decode(response.body));
      } else {
        throw Exception("Failed to get API");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to Load Post");
    }
  }

  // Method to get all Surahs
  Future<List<Surah>> getSurah() async {
    Response res = await http.get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('Number of Surahs: ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }

  // Method to get Juz based on index
  Future<JuzModel> getJuzz(int index) async {
    final url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception("Failed to get Juz data");
    }
  }

  // FutureBuilder to display Juz List
  FutureBuilder<JuzModel> buildJuzListFutureBuilder(
      ApiServices apiServices, int? juzIndex) {
    return FutureBuilder<JuzModel>(
      future: apiServices.getJuzz(juzIndex!),
      builder: (context, AsyncSnapshot<JuzModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          print('${snapshot.data!.juzAyahs.length} length');
          return ListView.builder(
            itemCount: snapshot.data!.juzAyahs.length,
            itemBuilder: (context, index) {
              return JuzCustomTile(
                list: snapshot.data!.juzAyahs,
                index: index,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}
