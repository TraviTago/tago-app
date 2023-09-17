import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/component/shimmer_box.dart';

class PlaceRecommendShimmerCard extends StatelessWidget {
  const PlaceRecommendShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = width; // Assuming a square-shaped card

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            children: [
              // Shimmer for the image
              ShimmerBox(width: width, height: height),

              // Positioned container at the bottom for title, address, and overview
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: (width) / 5 * 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[
                        400]!, // A neutral background color for the shimmer.
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer for the title
                        ShimmerBox(width: width * 0.6, height: 15.0),

                        // Space
                        const SizedBox(height: 5.0),

                        // Shimmer for the address
                        ShimmerBox(width: width * 0.5, height: 12.0),

                        // Space
                        const SizedBox(height: 5.0),

                        // Shimmer for the overview
                        ShimmerBox(width: width * 0.8, height: 11.0),
                        ShimmerBox(width: width * 0.7, height: 11.0),
                        ShimmerBox(width: width * 0.85, height: 11.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
