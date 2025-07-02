import 'package:flutter/material.dart';
import 'package:module_gym/theme/Colours.dart';

class RightGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 0,
      width: 140, // adjust this as needed
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.centerLeft,
            colors: [
              Colors.transparent,
              Theme.of(context).neonGreen, // semi-transparent black
            ],
          ),
        ),
      ),
    );
  }

}