import 'package:flutter/material.dart';
import 'package:tago_app/common/component/shimmer_box.dart';

class TripRecommendShimmerCard extends StatelessWidget {
  const TripRecommendShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    double height = width; // Assuming a square-shaped card

    return Material(
      borderRadius: BorderRadius.circular(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            // Shimmer for the image
            ShimmerBox(width: width, height: height),

            // Positioned container at the bottom for date, name, current/max members, and places
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: (width) / 3,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Shimmer for the date and name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(width: width * 0.6, height: 15.0),
                              const SizedBox(height: 5.0),
                              ShimmerBox(width: width * 0.5, height: 12.0),
                            ],
                          ),
                          // Shimmer for the current/max members
                          const ShimmerBox(width: 40, height: 20),
                        ],
                      ),
                      // Shimmer for the places
                      ShimmerBox(width: width * 0.85, height: 11.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
