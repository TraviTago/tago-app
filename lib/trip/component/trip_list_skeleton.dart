import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tago_app/common/component/shimmer_text.dart';

class TripListSkeleton extends StatelessWidget {
  const TripListSkeleton({
    super.key,
    required this.isRecommend,
  });

  final bool isRecommend;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              if (index == 0 && isRecommend) {
                // First item is similar to the TripRecommendCard
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ShimmerText(width: 100, height: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ShimmerText(width: 150, height: 20),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerText(width: 150, height: 20),
                          const SizedBox(height: 10.0),
                          // Adding the Shimmer effect for the TripRecommendCard
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                );
              }
              // Other items are similar to the TripCard
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 1 || index == 0)
                      const ShimmerText(width: 50, height: 20),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShimmerText(width: 60, height: 10),
                                          ShimmerText(width: 80, height: 10),
                                        ],
                                      ),
                                      ShimmerText(width: 40, height: 15),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  ShimmerText(width: 200, height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
