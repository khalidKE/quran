import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/translations.dart';

class TranslationTile extends StatelessWidget {
  TranslationTile({
    super.key,
    required this.index,
    required this.surahTranslation,
  });

  final int index;
  final SurahTranslation surahTranslation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black26,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Constants.kprimary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
              ),
              Positioned(
                top: 3,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Text(
                    surahTranslation.aya ?? '0', // Default to '0' if null
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  surahTranslation.arabic_text ??
                      'No text available', // Default if null
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
