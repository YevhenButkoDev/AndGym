
import 'package:flutter/material.dart';

import '../components/MainAppBar.dart';
import '../components/NotificationWidget.dart';

class NotificationsPage extends StatelessWidget {

  static Future<List<String>> _noop() async {
    return List<String>.generate(20, (i) => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been standard dummy text ever since the 1500s');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Notifications'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: FutureBuilder<List<String>>(
            future: _noop(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final sessions = snapshot.data ?? [];
              if (sessions.isEmpty) {
                return Center(child: Text('No Notifications.'));
              }

              return ListView.separated(
                itemCount: sessions.length,
                separatorBuilder: (_, __) => SizedBox(height: 16),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = sessions[index];
                  return NotificationWidget(isActive: false, message: item, icon: 'assets/subscription.svg',);
                }
              );
            },
          )
        )
      );
  }

}