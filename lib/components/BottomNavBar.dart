import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:module_gym/theme/Colours.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).outerSpace,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10)
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                currentIndex: currentIndex,
                buttonIndex: 0,
                activeIcon: 'assets/home2.svg',
                disabledIcon: 'assets/home.svg',
                onTap: onTap,
              ),
              CustomButton(
                currentIndex: currentIndex,
                buttonIndex: 1,
                activeIcon: 'assets/maps-and-flags2.svg',
                disabledIcon: 'assets/maps-and-flags.svg',
                onTap: onTap,
              ),
              CustomButton(
                currentIndex: currentIndex,
                buttonIndex: 2,
                activeIcon: 'assets/event2.svg',
                disabledIcon: 'assets/event.svg',
                onTap: onTap,
              ),
              CustomButton(
                currentIndex: currentIndex,
                buttonIndex: 3,
                activeIcon: 'assets/user2.svg',
                disabledIcon: 'assets/user.svg',
                onTap: onTap,
              )
            ],
          )
        )
    );
  }
}

class CustomButton extends StatelessWidget {
  final int currentIndex;
  final int buttonIndex;
  final String activeIcon;
  final String disabledIcon;
  final Function(int) onTap;

  const CustomButton({
    required this.currentIndex,
    required this.buttonIndex,
    required this.activeIcon,
    required this.disabledIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == buttonIndex ? Theme.of(context).neonGreen : Theme.of(context).raisinBlack
      ),
      child: IconButton(
          icon: currentIndex == buttonIndex
              ? SvgPicture.asset(
                  activeIcon,
                  height: 34,
                  width: 34,
                )
              : SvgPicture.asset(
                  disabledIcon,
                  height: 34,
                  width: 34,
                ),
          onPressed: () => onTap(buttonIndex),
          padding: EdgeInsets.zero, // remove extra padding inside button
          constraints: const BoxConstraints(),
          iconSize: 34
      ),
    );
  }
}
