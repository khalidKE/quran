import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quran/API.dart';
import 'package:quran/ayahOfTheDay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HijriCalendar? _hijri;
  ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    // Initialize Hijri calendar with the current date
    _hijri = HijriCalendar.now();
    HijriCalendar.setLocal('en'); // Set English locale for Hijri calendar

    // Initialize Date Formatting for English locale
    initializeDateFormatting('en').then((_) {
      setState(() {}); // Rebuild widget to apply formatting
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var format = DateFormat('EEE, d MMM yyyy', 'en');
    var formattedDate = format.format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background_img.jpg'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: _hijri != null ? _hijri!.hDay.toString() : '',
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: _hijri != null ? _hijri!.longMonthName : '',
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: _hijri != null ? '${_hijri!.hYear}' : '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    FutureBuilder<AyaOfTheDay>(
                      future: _apiServices.getAyaOfTheDay(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Icon(Icons.sync_problem);
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasData && snapshot.data != null) {
                              return Container(
                                margin: EdgeInsets.all(16),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Center horizontally
                                  children: [
                                    Text(
                                      snapshot.data!.arText ??
                                          "No Arabic text available",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign:
                                          TextAlign.center, // Center the text
                                    ),
                                    Divider(
                                        color: Colors.black, thickness: 0.5),
                                    Text(
                                      snapshot.data!.enTran ??
                                          "No English translation available",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot.data!.surNumber
                                                        ?.toString() ??
                                                    '',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot.data!.surEnName ?? '',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Text('No data available');
                            }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
