import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OriginImageShimmer extends StatelessWidget {
  const OriginImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
