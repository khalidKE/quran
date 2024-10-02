import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:quran/ayahOfTheDay.dart';
// import 'package:flutter_quran_yt/models/aya_of_day.dart';

class ApiServices {
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url =
        "https://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to get api");
      throw Exception("Failed to Load Post");
    }
  }

  random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }
}
