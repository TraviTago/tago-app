import 'package:flutter/material.dart';

class PlaceSearchImageShimmer extends StatelessWidget {
  const PlaceSearchImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 5 * 2;
    double height = width * (1 / 3);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
    );
  }
}
