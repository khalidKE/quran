import 'package:flutter/material.dart';
import 'package:quran/Surah.dart';

Widget SurahCustomTile({
  required Surah surah,
  required VoidCallback ontap,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Add rounded corners
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            surah.name ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            surah.englishName ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
