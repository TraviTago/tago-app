import 'package:flutter/material.dart';
import 'package:tago_app/common/component/shimmer_box.dart';

class TripMemberSkeleton extends StatelessWidget {
  const TripMemberSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 60, height: 20),
            const SizedBox(
              height: 5,
            ),
            const ShimmerBox(width: 85, height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ShimmerBox(width: width, height: 250),
            ),
          ],
        ),
      ),
    );
  }
}
