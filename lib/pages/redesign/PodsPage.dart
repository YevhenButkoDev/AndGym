
import 'package:flutter/material.dart';
import 'package:module_gym/service/GymPodService.dart';
import 'package:module_gym/theme/Colours.dart';

import '../../components/PodFrame.dart';
import '../../constants/AppConstants.dart';
import '../../objects/GymPod.dart';
import '../PodDetailsPage.dart';

class PodsPage extends StatelessWidget {

  final GymPodService _gymPodService = GymPodService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search pod",
              hintStyle: TextStyle(
                fontSize: 18,
                height: 1.0,
                fontWeight: FontWeight.w400,
                letterSpacing: AppConstants.textLetterSpacing,
                color: Theme.of(context).raisinBlack,
              ),
              filled: true,
              fillColor: Theme.of(context).neonGreen,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none, // remove border line
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
              fontSize: 18,
              height: 1.0,
              fontWeight: FontWeight.w400,
              letterSpacing: AppConstants.textLetterSpacing,
              color: Theme.of(context).raisinBlack,
            ),
          ),

          SizedBox(height: 16,),

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
                        separatorBuilder: (_, __) => SizedBox(height: 16),
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
                              child: PodFrame(
                                isFeatured: false,
                                imageUrl: 'https://picsum.photos/200/300',
                                onBookPressed: () => {},
                                onDetailsPressed: () => {},
                                onFeaturedPressed: () => {},
                              )
                          );
                        });
                  }
              )
          ),
        ],
      )
    );
  }

}