import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/model/trip_model.dart';

class TripRecommendCard extends StatelessWidget {
  final int tripId;
  final DateTime dateTime;
  final String name;
  final String imageUrl;
  final List<String> places;
  final int maxMember; //최대 인원
  final int currentMember; //현재 인원
  final int totalTime;
  final bool isCompleteCompnent;
  final bool isMyTrip;
  const TripRecommendCard({
    required this.tripId,
    required this.dateTime,
    required this.name,
    required this.imageUrl,
    required this.places,
    required this.maxMember,
    required this.currentMember,
    required this.totalTime,
    this.isCompleteCompnent = false,
    this.isMyTrip = false,
    Key? key,
  }) : super(key: key);

  factory TripRecommendCard.fromModel({
    required TripModel model,
    bool isCompleteCompnent = false,
    bool isMyTrip = false,
  }) {
    return TripRecommendCard(
      tripId: model.tripId,
      name: model.name,
      imageUrl: model.imageUrl,
      places: model.places,
      maxMember: model.maxMember,
      currentMember: model.currentMember,
      dateTime: model.dateTime,
      totalTime: model.totalTime,
      isCompleteCompnent: isCompleteCompnent,
      isMyTrip: isMyTrip,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width - 60; // List Screen 좌우 패딩 값을 뺸다.
    return GestureDetector(
      onTap: () {
        context.go("/tripDetail/$tripId");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: <Widget>[
            Image.network(
              imageUrl,
              width: screenWidth,
              height: screenWidth,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: (screenWidth) / 3,
                decoration: BoxDecoration(
                  color: TRIP_CARD_BLUR_COLOR.withOpacity(0.8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DateAndName(
                            date: dateTime,
                            name: name,
                            duration: totalTime,
                          ),
                          if (!isCompleteCompnent)
                            _PersonLabel(
                                curNum: currentMember, maxNum: maxMember)
                        ],
                      ),
                      Text(
                        places.join(' · '),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                        ),
                      ),
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

class _PersonLabel extends StatelessWidget {
  final int curNum;
  final int maxNum;

  const _PersonLabel({
    required this.curNum,
    required this.maxNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: LABEL_BG_COLOR.withOpacity(0.9),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Text(
        '$curNum/$maxNum',
        style: const TextStyle(
          fontSize: 13.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DateAndName extends StatelessWidget {
  final String name;
  final DateTime date;
  final int duration;

  const _DateAndName({
    required this.name,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${DataUtils.formatDate(date)} - $name',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '소요시간 ${DataUtils.formatDuration(duration)}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
