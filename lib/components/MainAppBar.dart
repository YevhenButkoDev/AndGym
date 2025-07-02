import 'package:flutter/material.dart';
import 'package:module_gym/constants/AppConstants.dart';
import 'package:module_gym/theme/Colours.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
            title,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: AppConstants.textLetterSpacing,
                color: Theme.of(context).cottonSeed
            )
        ),
      ),
      centerTitle: false, // Align title to the left
      actions: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).raisinBlack
          ),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                iconSize: 20,
                color: Theme.of(context).neonGreen,
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              if (true)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          )
        ),
        SizedBox(width: 8,),
        Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).raisinBlack
            ),
            child: IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 20,
              color: Theme.of(context).neonGreen,
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
        ),
        SizedBox(width: 16,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}