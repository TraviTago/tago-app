import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/component/imageShimmer/trip_card_image_shimmer.dart';
import 'package:tago_app/trip/model/trip_model.dart';

class TripCard extends StatelessWidget {
  final int tripId;
  final DateTime dateTime;

  final String name;
  final String imageUrl;
  final List<String> places;
  final int maxMember; //최대 인원
  final int currentMember; //현재 인원
  final int totalTime;

  final String type;
  const TripCard({
    required this.tripId,
    required this.dateTime,
    required this.name,
    required this.imageUrl,
    required this.places,
    required this.maxMember,
    required this.currentMember,
    required this.totalTime,
    this.type = "USER",
    Key? key,
  }) : super(key: key);

  factory TripCard.fromModel({
    required String type,
    required TripModel model,
  }) {
    return TripCard(
      tripId: model.tripId,
      dateTime: model.dateTime,
      name: model.name,
      imageUrl: model.imageUrl,
      places: model.places,
      maxMember: model.maxMember,
      currentMember: model.currentMember,
      totalTime: model.totalTime,
      type: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == "USER") {
          context
              .go("/tripDetail/$tripId?tripDate=$dateTime&tripTime=$totalTime");
        } else {
          context.go(
              "/driver/tripDetailTabDriver/$tripId?tripDate=$dateTime&tripTime=$totalTime");
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              const TripCardImageShimmer(), // 로딩 미리보기
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: LABEL_BG_COLOR,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DateAndName(
                                  name: name,
                                  duration: totalTime,
                                ),
                                if (!DateTime.now().isAfter(
                                    dateTime.add(Duration(minutes: totalTime))))
                                  _PersonLabel(
                                      curNum: currentMember, maxNum: maxMember)
                              ],
                            ),
                            Text(
                              places.join(' · '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: LABEL_TEXT_SUB_COLOR,
                                fontSize: 11.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
      width: 50,
      height: 20,
      decoration: const BoxDecoration(
        color: LABEL_BG_COLOR,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Text(
        '$curNum/$maxNum 명',
        style: const TextStyle(
          fontSize: 11.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _DateAndName extends StatelessWidget {
  final String name;
  final int duration;

  const _DateAndName({
    required this.name,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            color: LABEL_TEXT_SUB_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          '소요시간 ${DataUtils.formatDuration(duration)}',
          style: const TextStyle(
            fontSize: 11,
            color: LABEL_TEXT_SUB_COLOR,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
