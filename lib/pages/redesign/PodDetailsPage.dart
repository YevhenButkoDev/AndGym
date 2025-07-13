import 'package:flutter/material.dart';
import 'package:module_gym/pages/BookingPage.dart';
import 'package:module_gym/theme/Colours.dart';

import '../../constants/AppConstants.dart';
import '../../service/BookingService.dart';


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
        'https://picsum.photos/200/300',
        'https://picsum.photos/200/300',
      ],
      'description': 'Treadmill, Bench Press, Dumbbells, Kettlebells',
    },
    '2': {
      'title': 'Gym Pod B',
      'isBooked': false,
      'images': [
        'https://picsum.photos/200/300',
        'https://picsum.photos/200/300',
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
            Row(
              children: [
                Expanded(child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: Theme.of(context).outerSpace,
                        padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // 👈 set radius here
                        )
                    ),
                    onPressed: () => {},
                    child: Text(
                        'Locate',
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: AppConstants.textLetterSpacing,
                            color: Theme.of(context).cottonSeed)
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).neonGreen,
                      padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // 👈 set radius here
                      )
                    ),
                    onPressed: () => {},
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                      fontSize: 18,
                      height: 1.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: AppConstants.textLetterSpacing,
                      color: Theme.of(context).raisinBlack)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Equipment",
              style: TextStyle(
                  fontSize: 14,
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).cottonSeed
              ),
            ),
            SizedBox(height: 8),
            Text(
                podData['description'],
                style: TextStyle(
                    fontSize: 14,
                    height: 1.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).cottonSeed
                )
            ),
            SizedBox(height: 8),
            if (podData['isBooked'])
              Column(children: [
                Text(
                  "Your next session here:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("${podData['nextSessionDate']} at ${podData['nextSessionTimeStart']} - ${podData['nextSessionTimeEnd']}")
              ]),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}