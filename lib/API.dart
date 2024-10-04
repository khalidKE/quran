// import 'dart:convert';
// import 'package:http/http.dart' as http; // Only keep this import
// import 'package:quran/Surah.dart';
// import 'dart:math';
// import 'package:quran/ayahOfTheDay.dart';
// import 'package:quran_controller/quran_controller.dart';
// class ApiServices {
//   final endPointUrl = "http://api.alquran.cloud/v1/surah";
//   final _random = Random();

//   Future<AyaOfTheDay> getAyaOfTheDay() async {
//     try {
//       final url =
//           "https://api.alquran.cloud/v1/ayah/${_random.nextInt(6237) + 1}/editions/quran-uthmani,en.asad,en.pickthall";
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         return AyaOfTheDay.fromJSON(json.decode(response.body));
//       } else {
//         throw Exception("Failed to get api");
//       }
//     } catch (e) {
//       print("Error: $e");
//       throw Exception("Failed to Load Post");
//     }
//   }

//   Future<List<Surah>> getSurah() async {
//     try {
//       final response = await http.get(Uri.parse(endPointUrl));

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final list = <Surah>[];

//         for (final element in json['data']) {
//           list.add(Surah.fromJson(element));
//         }

//         return list;
//       } else {
//         throw Exception("Can't get the Surah");
//       }
//     } catch (e) {
//       print("Error: $e");
//       throw Exception("Failed to Load Post");
//     }
//   }
// }

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
