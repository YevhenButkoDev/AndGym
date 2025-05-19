import 'package:flutter/material.dart';
import 'package:module_gym/objects/Booking.dart';
import 'package:module_gym/pages/PodDetailsPage.dart';

class BookingsPage extends StatelessWidget {
  final List<Booking> bookings;

  const BookingsPage({super.key, required this.bookings});

  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.yellow.shade100;
      case 2:
        return Colors.green.shade100;
      case 3:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: bookings.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PodDetailsPage(podId: booking.id),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: Colors.teal),
                title: Text(booking.time),
                subtitle: Text('subtitle'),
                trailing: IconButton(
                  icon: Icon(Icons.lock_open_rounded, color: Colors.blueGrey),
                  onPressed: () {
                    // TODO: Open map or show location
                  },
                ),
                tileColor: _getStatusColor(booking.status),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              )
          );
        },
      ),
    );
  }
}
