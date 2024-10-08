import 'package:flutter/material.dart';

Widget SajdaCustomTile(SajdaAyat, context) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)]),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: Text(
                SajdaAyat.juzNumber.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${SajdaAyat.surahEnglishName} \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(
                      text: SajdaAyat.revelationType,
                      style: TextStyle(color: Colors.black))
                ])),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            Spacer(),
            Text(
              SajdaAyat.surahName,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        )
      ],
    ),
  );
}
