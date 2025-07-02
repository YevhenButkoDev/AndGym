import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_gym/theme/Colours.dart';

import '../constants/AppConstants.dart';


class MiddleBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MiddleBarButton(
          onPressed: () => {},
          iconPath: 'assets/schedule.svg',
          title: 'Schedule',
        ),

        MiddleBarButton(
          onPressed: () => {},
          iconPath: 'assets/subscription.svg',
          title: 'Subscription',
        ),

        MiddleBarButton(
          onPressed: () => {},
          iconPath: 'assets/invite.svg',
          title: 'Invite',
        ),

        MiddleBarButton(
          onPressed: () => {},
          iconPath: 'assets/about.svg',
          title: 'About',
        ),
      ],
    );
  }

}

class MiddleBarButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String iconPath;
  final String title;

  const MiddleBarButton({
    required this.onPressed,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 76,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Theme.of(context).outerSpace,
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 👈 set radius here
                )
            ),
            onPressed: onPressed,
            child: SvgPicture.asset(
              iconPath,
              height: 28,
              width: 36,
              colorFilter: ColorFilter.mode(Theme.of(context).cottonSeed, BlendMode.srcIn),
            ),
          ),
        ),

        SizedBox(height: 6),

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            height: 1.0,
            fontWeight: FontWeight.w400,
            letterSpacing: AppConstants.textLetterSpacing,
            color: Theme.of(context).cottonSeed)
        )
      ],
    );
  }

}