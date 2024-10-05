import 'package:flutter/material.dart';
//import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:quran/API.dart';

class JuzScreen extends StatefulWidget {
  static const String id = 'juz_screen';
  ApiServices apiServices = ApiServices();

  JuzScreen({super.key});

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<JuzScreen>(
          future: ApiService.getJuzz,
          builder: (context, AsyncSnapshot<JuzScreen> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print('${snapshot.data!.juzAyahs.length} length');
            }
            else{
              
            }
          }),
    ));
  }
}
