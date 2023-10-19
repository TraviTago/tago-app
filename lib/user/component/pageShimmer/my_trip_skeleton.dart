import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyTripSkeleton extends StatelessWidget {
  const MyTripSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(5, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3.0),
                        ),
                      ),
                      width: 100,
                      height: 20.0,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3.0),
                        ),
                      ),
                      width: 200,
                      height: 15.0,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
