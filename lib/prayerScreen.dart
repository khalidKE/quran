import 'package:flutter/material.dart';

class Prayer {
  final String name;
  final String time;

  Prayer({required this.name, required this.time});
}

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  _PrayerScreenState createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final List<Prayer> prayers = [
    Prayer(name: 'Fajr', time: '5:00 AM'),
    Prayer(name: 'Dhuhr', time: '12:30 PM'),
    Prayer(name: 'Asr', time: '3:45 PM'),
    Prayer(name: 'Maghrib', time: '6:15 PM'),
    Prayer(name: 'Isha', time: '7:45 PM'),
  ];

  String selectedAdhan = 'Default Adhan';
  String? selectedPrayer;
  String notificationFrequency = 'Daily';

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notification Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Adhan Selection
              DropdownButton<String>(
                value: selectedAdhan,
                items: <String>['Default Adhan', 'Adhan 1', 'Adhan 2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAdhan = newValue!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
              // Prayer Selection
              DropdownButton<String>(
                hint: const Text('Select Prayer'),
                value: selectedPrayer,
                items: prayers.map<DropdownMenuItem<String>>((Prayer prayer) {
                  return DropdownMenuItem<String>(
                    value: prayer.name,
                    child: Text(prayer.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPrayer = newValue!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
              // Notification Frequency
              DropdownButton<String>(
                value: notificationFrequency,
                items: <String>['Daily', 'Weekly', 'Monthly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    notificationFrequency = newValue!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Prayer Times',
            style: TextStyle(color: Color.fromARGB(174, 0, 0, 0)),
          ),
          backgroundColor: const Color.fromARGB(30, 96, 125, 139),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _showSettingsDialog,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: prayers.isEmpty
              ? const Center(child: Text('No prayer times available.'))
              : ListView.builder(
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    return PrayerTile(prayer: prayers[index]);
                  },
                ),
        ),
      ),
    );
  }
}

class PrayerTile extends StatelessWidget {
  final Prayer prayer;

  const PrayerTile({
    Key? key,
    required this.prayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayer.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  prayer.time,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.access_time,
              color: Colors.blueGrey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
