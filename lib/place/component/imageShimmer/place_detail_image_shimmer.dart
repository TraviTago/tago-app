import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceDetailImageShimmer extends StatelessWidget {
  const PlaceDetailImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
