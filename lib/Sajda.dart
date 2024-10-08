class SajdaAyat {
  final int? number;
  final String? text;
  final String? surahName;
  final String? surahEnglishName;
  final String? englishNameTranslation;
  final String? revelationType;
  final int? juzNumber;
  final int? nanzilName;
  final int? rukuNumber;
  final int? sajdaNumber;

  SajdaAyat(
      {required this.number,
      required this.text,
      required this.surahName,
      required this.surahEnglishName,
      required this.englishNameTranslation,
      required this.revelationType,
      required this.juzNumber,
      required this.nanzilName,
      required this.rukuNumber,
      required this.sajdaNumber});
  factory SajdaAyat.fromJSON(Map<String, dynamic> json) {
    print("Parsing SajdaAyat JSON: $json");

    return SajdaAyat(
      number: json['number'],
      text: json['text'],
      surahName: json['surah']['name'],
      surahEnglishName: json['surah']['englishName'],
      englishNameTranslation: json['surah']['englishTranslation'],
      revelationType: json['surah']['revelationType'],
      juzNumber: json['juz'],
      nanzilName: json['nanzil'],
      rukuNumber: json['ruku'],
      sajdaNumber: json['sajda']['id'],
    );
  }
}

class SajdaList {
  final List<SajdaAyat> sajdaAyahs;
  SajdaList({required this.sajdaAyahs});
  factory SajdaList.fromJSON(Map<String, dynamic> json) {
    Iterable allSajdas = json['data']['ayahs'];
    List<SajdaAyat> sajdas =
        allSajdas.map((e) => SajdaAyat.fromJSON(e)).toList();
    return SajdaList(sajdaAyahs: sajdas);
  }
}
