
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:module_gym/service/GymPodService.dart';
import 'package:module_gym/service/LocationService.dart';
import 'package:module_gym/theme/Colours.dart';
import 'package:module_gym/pages/redesign/PodDetailsPage.dart';

import '../../components/PodFrame.dart';
import '../../constants/AppConstants.dart';
import '../../objects/GymPod.dart';


class PodsPage extends StatefulWidget {
  const PodsPage({super.key});

  @override
  State<PodsPage> createState() => _PodsPage();
}

class _PodsPage extends State<PodsPage> {
  final GymPodService _gymPodService = GymPodService();
  final LocationService _locationService = LocationService();

  int _selectedIndex = 0;
  late Position _currentPosition;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _locationService.getCurrentLocation().then((position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search ...",
              hintStyle: TextStyle(
                fontSize: 18,
                height: 1.0,
                fontWeight: FontWeight.w400,
                letterSpacing: AppConstants.textLetterSpacing,
                color: Theme.of(context).midGrey,
              ),
              filled: true,
              fillColor: Theme.of(context).neonGreen,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none, // remove border line
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).raisinBlack,
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

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: 'Best',
                currentIndex: _selectedIndex,
                buttonIndex: 0,
                onTap: _onNavBarTapped,
              ),
              CustomButton(
                title: 'Nearby',
                currentIndex: _selectedIndex,
                buttonIndex: 1,
                onTap: _onNavBarTapped,
              ),
              CustomButton(
                title: 'Find on Map',
                currentIndex: _selectedIndex,
                buttonIndex: 2,
                onTap: _onNavBarTapped,
              ),
            ],
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
                                imageUrl: 'https://picsum.photos/200/300',
                                onDetailsPressed: () => {},
                                size: 'small',
                                onBookPressed: () => {},
                                onFeaturedPressed: () => {}
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

class CustomButton extends StatelessWidget {
  final int currentIndex;
  final int buttonIndex;
  final String title;
  final Function(int) onTap;

  const CustomButton({
    required this.currentIndex,
    required this.buttonIndex,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton(
        onPressed: () => onTap(buttonIndex),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: currentIndex == buttonIndex ? Theme.of(context).neonGreen : Theme.of(context).outerSpace,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14), // 👈 set radius here
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: AppConstants.textLetterSpacing,
                  color: currentIndex == buttonIndex ? Theme.of(context).outerSpace : Theme.of(context).cottonSeed
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    );
  }
}