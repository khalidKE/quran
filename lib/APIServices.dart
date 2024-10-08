import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:quran/Sajda.dart';
import 'package:quran/Surah.dart';
import 'dart:math';
import 'package:quran/ayahOfTheDay.dart';
import 'package:quran/juz.dart';
import 'package:quran/translations.dart';

class ApiServices {
  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  final String url = "http://api.alquran.cloud/v1/sajda/en.asad";
  final _random = Random();
  List<Surah> list = [];
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    try {
      final url =
          "https://api.alquran.cloud/v1/ayah/${_random.nextInt(6237) + 1}/editions/quran-uthmani,en.asad,en.pickthall";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return AyaOfTheDay.fromJSON(json.decode(response.body));
      } else {
        throw Exception("Failed to get api");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to Load Post");
    }
  }

  Future<List<Surah>> getSurah() async {
    try {
      print("Fetching Surah data...");
      Response res = await http.get(Uri.parse(endPointUrl));

      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        print("Surah API Response: $json");
        json['data'].forEach((element) {
          if (list.length < 114) {
            list.add(Surah.fromJson(element));
          }
        });
        print('Surah List Length: ${list.length}');
        return list;
      } else {
        print('Error: ${res.statusCode}');
        throw Exception("Failed to get Surah");
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception("Failed to Load Surah");
    }
  }

  Future<SajdaList> getSajda() async {
    try {
      print("Fetching Sajda data...");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Sajda API Response: $data");
        return SajdaList.fromJSON(data);
      } else {
        print('Sajda API Error: ${response.statusCode}');
        throw Exception("Failed to load Sajda");
      }
    } catch (e) {
      print('Sajda API Error: $e');
      throw Exception("Failed to load Sajda");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Get Juzz");
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to Load Post");
    }
  }

  Future<SurahTranslationList> getTranslation(int index) async {
    final url =
        "https://quranenc.com/api/v1/translation/sura/english_rwwad/$index";
    var res = await http.get(Uri.parse(url));
    return SurahTranslationList.fromJson(json.decode(res.body));
  }
}
