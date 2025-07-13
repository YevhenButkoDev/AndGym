
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:module_gym/theme/Colours.dart';

import '../constants/AppConstants.dart';

class PodFrame extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onBookPressed;
  final VoidCallback onDetailsPressed;
  final VoidCallback onFeaturedPressed;
  final bool isFeatured;
  final String size; // small, large

  const PodFrame({
    super.key,
    required this.imageUrl,
    required this.onBookPressed,
    required this.onDetailsPressed,
    required this.onFeaturedPressed,
    this.isFeatured = false,
    this.size = 'large'
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size == 'small' ? 185 : 290,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 14,
            right: 14,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isFeatured ? Theme.of(context).neonGreen : Theme.of(context).raisinBlack, // optional background
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: isFeatured
                    ? SvgPicture.asset('assets/featured-active.svg')
                    : SvgPicture.asset(
                        'assets/featured-not-active.svg',
                        colorFilter: ColorFilter.mode(Theme.of(context).neonGreen, BlendMode.srcIn),
                      ),
                onPressed: () {
                  // Your logic
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140, // adjust this as needed
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color.fromARGB(180, 0, 0, 0), // semi-transparent black
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 14,
            left: 14,
            right: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Address Address',
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: AppConstants.textLetterSpacing,
                            color: Theme.of(context).neonGreen)
                    ),
                    SizedBox(height: 6,),
                    Text(
                        'Address Address',
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: AppConstants.textLetterSpacing,
                            color: Theme.of(context).cottonSeed)
                    )
                  ],
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).neonGreen,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 👈 set radius here
                      )
                  ),
                  onPressed: () => {},
                  child: Text(
                      'Book Now',
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: AppConstants.textLetterSpacing,
                          color: Theme.of(context).raisinBlack)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}