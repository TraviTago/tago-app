import 'package:flutter/material.dart';
import 'package:tago_app/place/component/imageShimmer/place_search_image_shimmer.dart';

class PlaceSearchSkeleton extends StatelessWidget {
  const PlaceSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: PlaceSearchImageShimmer(),
          );
        },
      ),
    );
  }
}
