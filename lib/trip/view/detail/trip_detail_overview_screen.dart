import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/detail/trip_member_card.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/place/component/place_card.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripDetailOverViewScreen extends ConsumerWidget {
  final TripDetailModel detailModel;
  final TripStatus tripStatus;
  final int tripId;

  const TripDetailOverViewScreen({
    super.key,
    required this.detailModel,
    required this.tripStatus,
    required this.tripId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<TripStatusModel> statusModel =
        ref.watch(tripRepositoryProvider).getStatusTrip(tripId: tripId);
    return DefaultLayout(
      //TOFIX: FloatingButton 케이스
      // 내여행일 경우: floating 버튼 없음
      // 내여행이 아닌 경우:
      // 다가오는 여행일 경우 -> 참여하기 버튼
      // 진행중인 여행 or 지난 여행일 경우  -> 참여 불가 버튼
      floatingActionButton: tripStatus == TripStatus.upcoming
          ? MaterialButton(
              onPressed: () {},
              color: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text(
                  '참여하기',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(BUTTON_BG_COLOR),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
              ),
              onPressed: null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  '마감된 여행이에요',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),

      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView.builder(
            itemCount: detailModel.places.length + 1, // 1을 추가
            itemBuilder: (context, index) {
              if (index < detailModel.places.length) {
                final place = detailModel.places[index];
                return PlaceCard(place: place, index: index);
              } else {
                return Column(
                  children: [
                    if (tripStatus == TripStatus.upcoming)
                      FutureBuilder<TripStatusModel>(
                        future: statusModel,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            final statusModelData = snapshot.data;
                            return TripMemberCard(
                                statusModel: statusModelData!);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    SizedBox(
                      width: double.infinity,
                      //TOFIX: 하단 버튼 출력 케이스
                      //내 여행이 아닐 경우 하단 버튼 없음
                      //내 여행일 경우:
                      //현재 진행중인 여행일 경우 실시간 신고 버튼까지 출력
                      //지나간 여행 또는 다가오는 여행일 경우 메이트 보기만 출력
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              context.push("/tripDetail/$tripId/members");
                            },
                            color: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 0,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '내 여행메이트 정보 보러가기 ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (tripStatus == TripStatus.ongoing)
                            MaterialButton(
                              onPressed: () {
                                context.go('/customerReport');
                              },
                              color: LABEL_BG_COLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '실시간 불편신고',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        color: LABEL_TEXT_SUB_COLOR,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: LABEL_TEXT_SUB_COLOR,
                                      size: 25.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
