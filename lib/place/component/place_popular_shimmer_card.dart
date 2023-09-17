import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tago_app/common/component/shimmer_box.dart';

class PlacePopularShimmerCard extends StatelessWidget {
  const PlacePopularShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 5 * 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            children: [
              // Shimmer for Image section
              ShimmerBox(width: screenWidth, height: screenWidth * 2 / 3),
              // Shimmer for Text details section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(
                        width: screenWidth * 0.6,
                        height: 12.0), // Title Shimmer
                    const SizedBox(height: 5.0),
                    ShimmerBox(
                        width: screenWidth * 0.5,
                        height: 10.0), // Address Shimmer
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
