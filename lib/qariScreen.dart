import 'package:flutter/material.dart';
import 'package:quran/APIServices.dart';
import 'package:quran/QariCustomTile.dart';
import 'package:quran/qari.dart';
import 'audio_surah_screen.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  _QariListScreenState createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  final ApiServices apiServices = ApiServices();
  List<Qari> allQaris = [];
  List<Qari> filteredQaris = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchQariList();
  }

  Future<void> _fetchQariList() async {
    try {
      final qariList = await apiServices.getQariList();
      if (mounted) {

        setState(() {
          allQaris = qariList;
          filteredQaris = qariList;
        });
      }
    } catch (e) {

    }
  }

  void _filterQaris(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      filteredQaris = allQaris.where((qari) {
        return qari.name!.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Qari\'s'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              Expanded(child: _buildQariList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: _filterQaris,
      decoration: InputDecoration(
        hintText: 'Search Qari...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    );
  }

  Widget _buildQariList() {
    if (filteredQaris.isEmpty && searchQuery.isNotEmpty) {
      return const Center(
        child: Text(
          'No Qari found.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredQaris.length,
      itemBuilder: (context, index) {
        return QariCustomTile(
          qari: filteredQaris[index],
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AudioSurahScreen(qari: filteredQaris[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    
  }
}
