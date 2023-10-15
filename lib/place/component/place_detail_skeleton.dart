import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tago_app/common/component/shimmer_text.dart';

class PlaceDetailSkeleton extends StatelessWidget {
  const PlaceDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
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
          ),
          const SizedBox(height: 20.0),
          const ShimmerText(width: 180, height: 20),
          ShimmerText(width: MediaQuery.of(context).size.width, height: 12),
          ShimmerText(width: MediaQuery.of(context).size.width, height: 12),
          ShimmerText(width: MediaQuery.of(context).size.width, height: 12),
          ShimmerText(width: MediaQuery.of(context).size.width, height: 12),
          ShimmerText(width: MediaQuery.of(context).size.width, height: 12),
          const SizedBox(
            height: 10.0,
          ),
          const ShimmerText(width: 50, height: 12),
          const SizedBox(
            height: 20.0,
          ),
          const ShimmerText(width: 150, height: 12),
          const ShimmerText(width: 150, height: 12),
          const ShimmerText(width: 150, height: 12),
          const ShimmerText(width: 150, height: 12),
        ],
      ),
    );
  }
}
