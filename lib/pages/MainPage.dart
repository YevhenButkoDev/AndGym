import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:module_gym/pages/BookingPage.dart';
import 'package:module_gym/pages/BookingsPage.dart';
import 'package:module_gym/pages/PodDetailsPage.dart';
import 'package:module_gym/service/BookingService.dart';
import 'package:module_gym/service/GymPodService.dart';

import '../objects/GymPod.dart';

class MainPage extends StatelessWidget {
  final List<Map<String, dynamic>> sessions = [
    {"id": "pod1", "image": "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif", "title": "Yoga with Anna"},
    {"id": "pod2", "image": "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif", "title": "Boxing with Mike"},
    {"id": "pod3", "image": "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif", "title": "HIIT with Sara"},
  ];
  final GymPodService _gymPodService = GymPodService();
  final BookingService _bookingService = BookingService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Mod Gym")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Search pod"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out"),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<GymPod>>(
                future: _gymPodService.fetchAllPods(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final sessions = snapshot.data ?? [];
                  if (sessions.isEmpty) {
                    return Center(child: Text('No Gym Pods found.'));
                  }

                  return ListView.separated(
                      itemCount: sessions.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final item = sessions[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                    PodDetailsPage(podId: item.id),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: AspectRatio(
                                      aspectRatio: 1, // 1:1 = square
                                      child: Image.network(
                                        "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    item.price.toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final data = await BookingService().fetchBookedSections(item.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BookingPage(podId: item.id, bookedSections: data)),
                                      );
                                    },
                                    child: Text("Book"),
                                  )
                                ],
                              ),
                            )
                        );
                      });
                  }
              )
            ),
            SizedBox(height: 16),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(8),
                          ),
                          child: Icon(Icons.camera_alt),
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.map)
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          final bookings = await _bookingService.fetchBookings();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => BookingsPage(bookings: bookings,)),
                          );
                        },
                        icon: Icon(Icons.calendar_today),
                      ),
                    )
                  ],
                )
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
