import 'package:flutter/material.dart';
import 'package:module_gym/pages/BookingPage.dart';

import '../service/BookingService.dart';


class PodDetailsPage extends StatelessWidget {
  final int podId;
  final Map<String, Map<String, dynamic>> mockPodData = {
    '1': {
      'title': 'Gym Pod A',
      'isBooked': true,
      'nextSessionDate': '2025-04-29',
      'nextSessionTimeStart': '10:00',
      'nextSessionTimeEnd': '11:30',
      'images': [
        'https://placehold.co/300X600/png',
        'https://placehold.co/300X600/png',
      ],
      'description': 'Treadmill, Bench Press, Dumbbells, Kettlebells',
    },
    '2': {
      'title': 'Gym Pod B',
      'isBooked': false,
      'images': [
        'https://placehold.co/300X600/png',
        'https://placehold.co/300X600/png',
      ],
      'description': 'Rowing Machine, Pull-up Bar, Medicine Balls',
    },
  };

  PodDetailsPage({required this.podId});

  @override
  Widget build(BuildContext context) {
    final podData = mockPodData[podId.toString()]!;

    return Scaffold(
      appBar: AppBar(title: Text(podData['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: podData['images'].length,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    podData['images'][index],
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Equipment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(podData['description']),
            SizedBox(height: 8),
            if (podData['isBooked'])
              Column(children: [
                Text(
                  "Your next session here:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("${podData['nextSessionDate']} at ${podData['nextSessionTimeStart']} - ${podData['nextSessionTimeEnd']}")
              ]),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle locate action
                    },
                    child: Text("Locate"),
                  ),
                ),
                SizedBox(width: 16),
                podData['isBooked']
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final data = await BookingService().fetchBookedSections(podId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BookingPage(podId: podId, bookedSections: data)),
                      );
                    },
                    child: Text("Cancel Booking"),
                  ),
                )
                    : Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final data = await BookingService().fetchBookedSections(podId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BookingPage(podId: podId, bookedSections: data)),
                      );
                    },
                    child: Text("Book"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}