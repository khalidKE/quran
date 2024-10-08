import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/constants.dart';
import 'package:quran/juz.dart';

class JuzScreen extends StatefulWidget {
  static const String id = 'juz_screen';
  final ApiServices apiServices = ApiServices();

  JuzScreen({super.key});

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<JuzModel>(
          future: widget.apiServices
              .getJuzz(Constants.juzIndex!), // Correct future call
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print('${snapshot.data!.juzAyahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.juzAyahs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.juzAyahs[index].ayahsText),
                    subtitle: Text(snapshot.data!.juzAyahs[index].surahName),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
