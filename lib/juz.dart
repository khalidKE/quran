class JuzModel {
  final int juzNumber;
  final List<JuzAyahs> juzAyahs;

  JuzModel({required this.juzAyahs, required this.juzNumber});

  factory JuzModel.fromJSON(Map<String, dynamic> json) {
    List<dynamic> ayahs = json['data']['ayahs']; // Extracting ayahs list
    List<JuzAyahs> juzAyahsList =
        ayahs.map((e) => JuzAyahs.fromJSON(e)).toList(); // Mapping each ayah

    return JuzModel(
      juzAyahs: juzAyahsList,
      juzNumber: json['data']['number'], // Fetching juz number
    );
  }
}

class JuzAyahs {
  final String ayahsText;
  final int ayahNumber;
  final String surahName;

  JuzAyahs(
      {required this.ayahsText,
      required this.surahName,
      required this.ayahNumber});

  factory JuzAyahs.fromJSON(Map<String, dynamic> json) {
    return JuzAyahs(
      ayahNumber: json['number'], // Fetching ayah number
      ayahsText: json['text'], // Fetching ayah text
      surahName: json['surah']['name'], // Fetching surah name
    );
  }
}
