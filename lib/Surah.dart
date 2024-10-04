class Surah {
  int? number;
  int? numberOfAyahs;
  String? name;
  String? englishName;
  String? englishTranslation;
  String? revelationType;

  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}
