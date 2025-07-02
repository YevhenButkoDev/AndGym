import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:module_gym/theme/Colours.dart';

import '../constants/AppConstants.dart';

class TrainingTimerPanel extends StatelessWidget {
  final String countdownText;
  final VoidCallback onOpenPressed;
  final VoidCallback onExtraTimePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onViewAllBookingsPressed;

  const TrainingTimerPanel({
    super.key,
    required this.countdownText,
    required this.onOpenPressed,
    required this.onExtraTimePressed,
    required this.onEditPressed,
    required this.onViewAllBookingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).neonGreen,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Your training will start in:',
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: AppConstants.textLetterSpacing,
                          color: Theme.of(context).darkGreen))
                ),

                SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerLeft,
                  child:
                  Text(
                    countdownText,
                    style: TextStyle(
                        fontSize: 36,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: AppConstants.textLetterSpacing,
                        color: Theme.of(context).darkGreen),
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Theme.of(context).darkGreen,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // 👈 set radius here
                          )
                        ),
                        onPressed: onOpenPressed,
                        child: Text(
                          "Open",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).neonGreen,
                              letterSpacing: AppConstants.textLetterSpacing
                          )
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child:
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).darkGreen),
                          foregroundColor: Theme.of(context).darkGreen,
                          padding: EdgeInsets.only(left: 2, right: 2, top: 4, bottom: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // 👈 set radius here
                          )
                        ),
                        onPressed: onExtraTimePressed,
                        child: Text(
                          "Book Extra Time",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              letterSpacing: AppConstants.textLetterSpacing),
                          ),
                      ),
                    )
                    ],
                  ),

                  SizedBox(height: 2,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Need any help? Contact us on WhatsApp',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).darkGreen,
                          letterSpacing: AppConstants.textLetterSpacing
                      ),
                    ),
                  ),
                ],
              ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/vector.svg',
                    height: 21,
                    width: 21,
                    colorFilter: ColorFilter.mode(Theme.of(context).darkGreen, BlendMode.srcIn),
                  ),
                  onPressed: onEditPressed,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.expand(width: 24, height: 24),
                ),
              ),
            )
        ],
      )
    );
  }
}