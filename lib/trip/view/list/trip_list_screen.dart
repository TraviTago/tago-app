import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/component/trip_card.dart';
import 'package:tago_app/trip/component/trip_recommend_card.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/provider/trip_provider.dart';

class TripListScreen extends ConsumerWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TripModel> trips = ref.watch(tripProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton.extended(
            shape: const CircleBorder(),
            label: const Icon(
              Icons.add,
              size: 45,
            ),
            onPressed: () {
              context.go('/tripForm1');
            },
            backgroundColor: PRIMARY_COLOR,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SingleChildScrollView(
          // 이 부분이 추가되었습니다.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '당신에게 딱 맞는 여행!',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TripRecommendCard.fromModel(model: tripData),
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shrinkWrap: true, // 이 부분이 추가되었습니다.
                physics: const NeverScrollableScrollPhysics(), // 이 부분이 추가되었습니다.
                itemCount: trips.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime? previousDate;
                  if (index - 1 >= 0) {
                    previousDate = trips[index - 1].dateTime;
                  }

                  final bool shouldShowDate = previousDate == null ||
                      !DataUtils.isSameDate(previousDate,
                          trips[index].dateTime); // 도우미 함수를 사용하여 같은 날짜인지 확인

                  if (shouldShowDate || index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DataUtils.formatDate(trips[index].dateTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TripCard.fromModel(model: trips[index]),
                      ],
                    );
                  } else {
                    return TripCard.fromModel(model: trips[index]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
