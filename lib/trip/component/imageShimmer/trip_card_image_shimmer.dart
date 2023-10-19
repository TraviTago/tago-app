import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TripCardImageShimmer extends StatelessWidget {
  const TripCardImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
