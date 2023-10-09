import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/detail/trip_member_card.dart';
import 'package:tago_app/trip/model/trip_detail_driver_model.dart';
import 'package:tago_app/place/component/place_card.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';
import 'package:tago_app/trip/provider/trip_provider.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripDetailOverviewDriverScreen extends ConsumerWidget {
  final TripDetailDriverModel detailModel;
  final TripStatus tripStatus;
  final int tripId;

  const TripDetailOverviewDriverScreen({
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
      floatingActionButton: detailModel.isDispatched == true
          ? null
          : MaterialButton(
              onPressed: () {
                try {
                  _showAcceptDoubleCheckDialog(context, tripStatus, ref);
                } catch (e) {
                  print(e);
                }
              },
              color: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Text(
                  '코스 수락하기',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: detailModel.places.length + 1, // 1을 추가
          itemBuilder: (context, index) {
            if (index < detailModel.places.length) {
              print(detailModel.isDispatched);

              final place = detailModel.places[index];
              return PlaceCard(place: place, index: index);
            } else {
              return Column(
                children: [
                  if (tripStatus == TripStatus.upcoming ||
                      tripStatus == TripStatus.upcomingSoon)
                    FutureBuilder<TripStatusModel>(
                      future: statusModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          final statusModelData = snapshot.data;
                          return TripMemberCard(statusModel: statusModelData!);
                        } else {
                          return const CircularProgressIndicator(
                              color: PRIMARY_COLOR);
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
                        if (detailModel.isDispatched == false)
                          const SizedBox(
                            height: 50.0,
                          ),
                        if (detailModel.isDispatched == true)
                          MaterialButton(
                            onPressed: () {
                              context.push(
                                  "/driver/tripDetailTabDriver/$tripId/driverMembers");
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
                                    '여행손님 상세정보 확인하기',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (detailModel.isDispatched == true &&
                            (tripStatus == TripStatus.upcoming ||
                                tripStatus == TripStatus.upcomingSoon))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: MaterialButton(
                              onPressed: () {
                                _showCancleDialog(context, ref, tripStatus);
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
                                      '코스운행 취소하기',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: LABEL_TEXT_SUB_COLOR,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: LABEL_TEXT_SUB_COLOR,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (tripStatus == TripStatus.ongoing &&
                            detailModel.isDispatched == true)
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
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: LABEL_TEXT_SUB_COLOR,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: LABEL_TEXT_SUB_COLOR,
                                    size: 20.0,
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
    );
  }

  void _showAcceptDoubleCheckDialog(
      BuildContext context, TripStatus statusModel, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                statusModel == TripStatus.upcomingSoon
                    ? "이 여행은 얼마 안 남아서\n수락하면 취소가 어려워요"
                    : '여행을 수락하시겠어요?',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          actions: [
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: LABEL_BG_COLOR,
                    width: 2.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0)),
                      ),
                      child: const Text(
                        '뒤로',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  const VerticalDivider(
                    color: LABEL_BG_COLOR, // 버튼이 만나는 지점의 세로 줄 색상
                    width: 2.0, // 세로 줄의 너비
                    thickness: 2.0, // 세로 줄의 두께
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0)),
                      ),
                      child: const Text(
                        '수락',
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await ref
                              .read(tripRepositoryProvider)
                              .postDetailTripDriver(
                                  tripId: tripId, state: "ACCEPT");

                          await ref.read(tripProvider.notifier).paginate();
                          context.pop();
                          _showAfterDialog(context, true, ref);
                        } catch (e) {
                          context.pop();
                          print(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAfterDialog(BuildContext context, bool isJoin, WidgetRef ref) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                isJoin ? '기사님, 멋진 여행을\n수락하셨네요!' : "다음에 함께해요!\n여행이 취소되었습니다",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            if (!isJoin)
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: LABEL_BG_COLOR,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0)),
                        ),
                        child: const Text(
                          '홈으로 돌아가기',
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          context.pop();
                          context.go('/driver');
                        },
                      ),
                    ),
                    const VerticalDivider(
                      color: LABEL_BG_COLOR, // 버튼이 만나는 지점의 세로 줄 색상
                      width: 2.0, // 세로 줄의 너비
                      thickness: 2.0, // 세로 줄의 두께
                    ),
                  ],
                ),
              ),
            if (isJoin)
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: LABEL_BG_COLOR,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0)),
                        ),
                        child: const Text(
                          '홈으로',
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          context.pop();
                          context.go('/driver');
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  void _showCancleDialog(
      BuildContext context, WidgetRef ref, TripStatus tripStatus) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "기사님 이 코스운행을\n취소하시겠어요?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: LABEL_BG_COLOR,
                    width: 2.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0)),
                      ),
                      child: const Text(
                        '네',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await ref
                              .read(tripRepositoryProvider)
                              .postDetailTripDriver(
                                  tripId: tripId, state: "CANCEL");

                          await ref.read(tripProvider.notifier).paginate();

                          context.pop();
                          _showAfterDialog(context, false, ref);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                  const VerticalDivider(
                    color: LABEL_BG_COLOR, // 버튼이 만나는 지점의 세로 줄 색상
                    width: 2.0, // 세로 줄의 너비
                    thickness: 2.0, // 세로 줄의 두께
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0)),
                      ),
                      child: const Text(
                        '아니오',
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
