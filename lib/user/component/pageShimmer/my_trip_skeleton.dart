import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tago_app/common/component/shimmer_text.dart';

class MyTripSkeleton extends StatelessWidget {
  const MyTripSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: List.generate(5, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: ShimmerText(
                        width: 80,
                        height: 16,
                      ),
                    ),
                  if (index == 0)
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: ShimmerText(
                        width: 170,
                        height: 16,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                    ),
                    width: width,
                    height: width - 40,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
