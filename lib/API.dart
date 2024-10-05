import 'dart:convert';
import 'package:http/http.dart' as http; // Only keep this import
import 'package:http/http.dart';
import 'package:quran/Surah.dart';
import 'dart:math';
import 'package:quran/ayahOfTheDay.dart';
import 'package:quran/juz.dart';
import 'package:quran_controller/quran_controller.dart';

class ApiServices {
  final endPointUrl = "http://api.alquran.cloud/v1/surah";
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
    Response res = await http.get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }

 // Future<SajdaList> getSajda() async {}

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to Load Post");
    }
  }
}
