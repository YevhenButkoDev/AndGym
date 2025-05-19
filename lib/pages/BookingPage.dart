import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_gym/service/BookingService.dart';
import 'package:module_gym/utils.dart';

import 'BookingsPage.dart';

class BookingPage extends StatefulWidget {
  final int podId;
  final Map<String, List<int>> bookedSections;

  BookingPage({
    required this.podId,
    required this.bookedSections
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  final _utils = Utils();
  final _bookingService = BookingService();

  DateTime selectedDate = DateTime.now();
  int selectedTimeIndex = 0;
  int periods = 1;

  late List<String> times;
  late int currentTimeIndexOffset;

  bool _isDisabled(int index) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return widget.bookedSections.containsKey(formattedDate) && widget.bookedSections[formattedDate]!.contains(index + currentTimeIndexOffset);
  }

  bool _isPeriodValid(int startIndex, int periodCount) {
    for (int i = 0; i < periodCount; i++) {
      if (_isDisabled(startIndex + i) || startIndex + i >= times.length) {
        return false;
      }
    }
    return true;
  }

  void generateAvailableTimes() {
    final now = DateTime.now();
    final isToday = DateFormat('yyyy-MM-dd').format(now) ==
        DateFormat('yyyy-MM-dd').format(selectedDate);

    final nowMinutes = now.hour * 60 + now.minute;

    final fullTimes = List.generate(24 * 2, (index) {
      final time = DateTime(0, 0, 0, index ~/ 2, (index % 2) * 30);
      return DateFormat('HH:mm').format(time);
    });

    times = [];
    currentTimeIndexOffset = 0;

    for (int i = 0; i < fullTimes.length; i++) {
      final parts = fullTimes[i].split(':');
      final minutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);

      if (!isToday || minutes > nowMinutes) {
        if (times.isEmpty) {
          currentTimeIndexOffset = i;
        }
        times.add(fullTimes[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    generateAvailableTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Session ${widget.podId}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                  onDateChanged: (date) {
                    setState(() => selectedDate = date);
                    generateAvailableTimes();
                    setState(() => periods = 1);
                    setState(() => selectedTimeIndex = 0);
                  },
                ),
                SizedBox(height: 16),
                Text("Select Time", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: times.length,
                    separatorBuilder: (_, __) => SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isDisabled = _isDisabled(index);
                      final endPeriod = selectedTimeIndex + periods;
                      final isSelected = selectedTimeIndex <= index && index < endPeriod;
                      return ChoiceChip(
                        label: Text(times[index]),
                        selected: isSelected,
                        onSelected: isDisabled
                            ? null
                            : (selected) {
                          setState(() => selectedTimeIndex = index);
                          setState(() => periods = 1);
                        },
                        selectedColor: Colors.teal,
                        disabledColor: Colors.grey.shade300,
                      );
                    },
                  ),
                ),
                Text("Number of Sessions", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (periods > 1) setState(() => periods--);
                      },
                    ),
                    Text("$periods", style: TextStyle(fontSize: 24)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (_isPeriodValid(selectedTimeIndex, periods + 1)) setState(() => periods++);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _bookingService.bookSection(
                          widget.podId,
                          selectedDate,
                          selectedTimeIndex + currentTimeIndexOffset, periods
                      );
                      // ✅ Payment succeeded – redirect
                      if (context.mounted) {
                        final bookings = await _bookingService.fetchBookings();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => BookingsPage(bookings: bookings)),
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) return;
                      _utils.showErrorDialog(context, e.toString());
                    }
                  },
                  child: Text("Book"),
                ),
              ],
            ),
      ),
    );
  }
}
