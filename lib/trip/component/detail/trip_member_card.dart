import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';

class TripMemberCard extends StatelessWidget {
  final TripStatusModel statusModel;

  const TripMemberCard({super.key, required this.statusModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '마지막으로',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 3.0,
          ),
          const Text(
            '확인해보세요!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LABEL_BG_COLOR,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  if (statusModel.maleCnt != 0 && statusModel.femaleCnt != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '현재 모집된 멤버는',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          if (statusModel.maleCnt != 0 &&
                              statusModel.femaleCnt == 0)
                            Text(
                              '남자 ${statusModel.maleCnt}명',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                          if (statusModel.femaleCnt != 0 &&
                              statusModel.maleCnt == 0)
                            Text(
                              '여자 ${statusModel.femaleCnt}명',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                          if (statusModel.maleCnt != 0 &&
                              statusModel.femaleCnt != 0)
                            Text(
                              '남자 ${statusModel.maleCnt}명 / 여자 ${statusModel.femaleCnt}명',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                        ],
                      ),
                    ),
                  if (statusModel.maleCnt != 0 && statusModel.femaleCnt != 0)
                    const SizedBox(
                      height: 15.0,
                    ),
                  if (statusModel.maleCnt != 0 && statusModel.femaleCnt != 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '연령대는',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Row(
                            children: [
                              for (var age in [...statusModel.ageGroup]..sort())
                                Container(
                                  margin: EdgeInsets.only(
                                      right: age != statusModel.ageGroup.last
                                          ? 5.0
                                          : 0.0),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 5.0,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20.0)),
                                  ),
                                  child: Text(
                                    '$age대',
                                    style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('출발 시간'),
                        Text(
                          statusModel.startTime,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('종료 시간'),
                        Text(
                          //TOFIX
                          statusModel.endTime,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
