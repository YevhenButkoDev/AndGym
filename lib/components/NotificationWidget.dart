
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:module_gym/theme/Colours.dart';

import '../constants/AppConstants.dart';

class NotificationWidget extends StatelessWidget {
  final bool isActive;
  final String message;
  final String icon;

  const NotificationWidget({
    super.key,
    required this.isActive,
    required this.message,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).outerSpace,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).raisinBlack,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Theme.of(context).neonGreen : Theme.of(context).cottonSeed,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(
              message,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: AppConstants.textLetterSpacing,
                  color: Theme.of(context).cottonSeed)
              )
          )
        ],
      ),
    );
  }

}