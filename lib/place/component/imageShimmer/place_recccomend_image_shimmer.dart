import 'package:flutter/material.dart';

class PlaceRecommendImageShimmer extends StatelessWidget {
  const PlaceRecommendImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
    );
  }
}
