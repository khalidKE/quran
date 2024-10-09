class SurahTranslationList {
  final List<SurahTranslation> translationList;

  SurahTranslationList({required this.translationList});

  factory SurahTranslationList.fromJson(Map<String, dynamic> map) {
    var translation = map['result'] as List;
    List<SurahTranslation> list =
        translation.map((e) => SurahTranslation.fromJson(e)).toList();
    return SurahTranslationList(translationList: list);
  }
}

class SurahTranslation {
  final String? sura;
  final String? aya;
  final String? arabicText;
  final String? translation;

  SurahTranslation({
    this.sura,
    this.aya,
    this.arabicText,
    this.translation,
  });

  factory SurahTranslation.fromJson(Map<String, dynamic> json) {
    return SurahTranslation(
      sura: json['sura'],
      aya: json['aya'],
      arabicText: json['arabic_text'],
      translation: json['translation'],
    );
  }
}
