import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/component/place_card.dart';

class TripEditDetailOverviewScreen extends ConsumerWidget {
  final List<PlaceModel> places;

  const TripEditDetailOverviewScreen({
    super.key,
    required this.places,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView.builder(
            itemCount: places.length + 1, // 1을 추가
            itemBuilder: (context, index) {
              if (index < places.length) {
                final place = places[index];
                return PlaceCard(place: place, index: index);
              } else {
                return const Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
