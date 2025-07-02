
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:module_gym/theme/Colours.dart';

import '../constants/AppConstants.dart';
import 'PodFrame.dart';

class FeaturedPods extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FeaturedPodsState();
  }
}

class _FeaturedPodsState extends State<FeaturedPods> {
  bool isLoading = true;
  String? responseData;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Featured Pods',
            style: TextStyle(
                fontSize: 20,
                height: 1.0,
                fontWeight: FontWeight.bold,
                letterSpacing: AppConstants.textLetterSpacing,
                color: Theme.of(context).cottonSeed),
                textAlign: TextAlign.start,)
        ),

        SizedBox(height: 12,),

        PodFrame(
          isFeatured: true,
          imageUrl: 'https://picsum.photos/200/300',
          onBookPressed: () => {},
          onDetailsPressed: () => {},
          onFeaturedPressed: () => {},
        )
      ],
    );
  }
}