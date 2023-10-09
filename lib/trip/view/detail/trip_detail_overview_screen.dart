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
import 'package:tago_app/trip/provider/trip_me_provider.dart';
import 'package:tago_app/trip/provider/trip_provider.dart';
import 'package:tago_app/trip/provider/trip_recommend_provider.dart';
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
      // 내여행일 경우: floating 버튼 없음
      // 내여행이 아닌 경우:
      // 다가오는 여행일 경우 -> 참여하기 버튼
      // 진행중인 여행 or 지난 여행일 경우  -> 참여 불가 버튼
      floatingActionButton: detailModel.isJoined == true
          ? null
          : (tripStatus == TripStatus.upcoming ||
                      tripStatus == TripStatus.upcomingSoon) &&
                  (detailModel.currentCnt < detailModel.maxCnt)
              ? MaterialButton(
                  //TOFIX
                  onPressed: () {
                    try {
                      _showJoinDoubleCheckDialog(context, tripStatus, ref);
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Text(
                      '참여하기',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      '마감되거나 가득 찬 여행이에요',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (detailModel.isJoined == false)
                          const SizedBox(
                            height: 50.0,
                          ),
                        if (detailModel.isJoined == true)
                          MaterialButton(
                            onPressed: () {
                              context.push(
                                "/tripDetail/$tripId/members",
                              );
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
                                    '내 여행메이트 정보 보러가기',
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
                        if (detailModel.isJoined && detailModel.isDispatched)
                          MaterialButton(
                            onPressed: () {
                              context.push("/tripDetail/$tripId/driver");
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
                                    '기사님 정보 보러가기',
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (detailModel.isJoined == true &&
                            (tripStatus == TripStatus.upcoming ||
                                tripStatus == TripStatus.upcomingSoon))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: MaterialButton(
                              onPressed: () {
                                _showLeaveDialog(context, ref, tripStatus);
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
                                      '내 여행 취소하기',
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
                            detailModel.isJoined == true)
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

  void _showJoinDoubleCheckDialog(
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
                    ? "이 여행은 얼마 안 남아서\n참여하면 취소가 어려워요"
                    : '여행에 참여하시겠어요?',
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
                        '참여할게요!',
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () async {
                        try {
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
                isJoin ? '멋진 여행을 추가하셨네요!' : "다음에 함께해요!\n여행이 취소되었습니다",
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
                          await ref.read(tripMeProvider.notifier).getMyTrip();
                          await ref.read(tripProvider.notifier).paginate();
                          await ref
                              .read(recommendProvider.notifier)
                              .fetchRecommendTrip();
                          context.pop();
                          context.go('/');
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
                          await ref
                              .read(tripRepositoryProvider)
                              .joinTrip(tripId: tripId);
                          await ref
                              .read(recommendProvider.notifier)
                              .fetchRecommendTrip();
                          await ref.read(tripProvider.notifier).paginate();
                          context.pop();
                          context.go('/');
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

  void _showLeaveDialog(
      BuildContext context, WidgetRef ref, TripStatus tripStatus) {
    showDialog(
      barrierDismissible: true,
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
                tripStatus == TripStatus.upcomingSoon
                    ? '이 여행은 취소가 불가능합니다!\n고객센터로 문의주세요!'
                    : "정말로 취소하시나요..?",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            if (tripStatus == TripStatus.upcomingSoon)
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
                            '뒤로가기',
                            style: TextStyle(
                              color: LABEL_TEXT_SUB_COLOR,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            context.pop();
                          }),
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
                                bottomLeft: Radius.circular(15.0)),
                          ),
                          child: const Text(
                            '문의하기',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            context.pop();
                            context.go('/customerCenter');
                          }),
                    ),
                  ],
                ),
              ),
            if (tripStatus == TripStatus.upcoming)
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
                          '네! 취소할래요',
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
                                .leaveTrip(tripId: tripId);

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
                          '아닙니다!',
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
