import 'package:flutter/material.dart';
import 'package:module_gym/theme/Colours.dart';

import '../../components/FeaturedPods.dart';
import '../../components/LiveTrainingCountdown.dart';
import '../../components/MiddleBar.dart';
import '../../components/TrainingTimerPanel.dart';
import '../../constants/AppConstants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiveTrainingCountdown(),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              onTap: () => {},
              child: Text(
                'View All Bookings ->',
                style: TextStyle(
                    fontSize: 12,
                    height: 1.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: AppConstants.textLetterSpacing,
                    color: Theme.of(context).cottonSeed,
                    decoration: TextDecoration.underline
                ),
                textAlign: TextAlign.start,
              ),
            )
          ),

          SizedBox(height: 16),
          MiddleBar(),

          SizedBox(height: 16),
          FeaturedPods()
        ],
      ),
    );
  }
}