import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/course/model/course_reponse_model.dart';
import 'package:tago_app/course/provider/course_provider.dart';
import 'package:tago_app/trip/component/trip_complete_card.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripCompleteScreen extends ConsumerStatefulWidget {
  static String get routeName => 'tripComplete';

  const TripCompleteScreen({super.key});

  @override
  ConsumerState<TripCompleteScreen> createState() => _TripCompleteScreenState();
}

class _TripCompleteScreenState extends ConsumerState<TripCompleteScreen> {
  bool isCheckedTrip = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CourseResponseModel? courseState = ref.watch(courseProvider);

    return DefaultLayout(
      backBtnComponent: true,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '짜잔! 완성되었어요',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '클릭해서 취향에 맞게 수정해보세요 ',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: LABEL_TEXT_SUB_COLOR,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TripCompleteCard(
                      dateTime: DateTime.parse(GoRouterState.of(context)
                          .queryParameters['dateTime']!),
                      name: GoRouterState.of(context).queryParameters['name']!,
                      imageUrl: courseState!.imgUrl,
                      places: courseState.places,
                      totalTime: courseState.totalTime),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        // Checkbox 크기 조정
                        scale: 1.2,
                        child: Checkbox(
                          activeColor: PRIMARY_COLOR,
                          side: const BorderSide(
                            width: 1,
                            color: SELECTED_BOX_BG_COLOR,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: isCheckedTrip,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isCheckedTrip = newValue ?? false;
                            });
                          },
                        ),
                      ),
                      const Text(
                        '코스 상세정보를 모두 확인했어요',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: !isCheckedTrip
                        ? MaterialStateProperty.all(LABEL_BG_COLOR)
                        : MaterialStateProperty.all(PRIMARY_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: !isCheckedTrip
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await ref.read(tripRepositoryProvider).createTrip({
                            "name": GoRouterState.of(context)
                                .queryParameters['name'],
                            "dateTime": GoRouterState.of(context)
                                .queryParameters['dateTime'],
                            "currentCnt": int.parse(GoRouterState.of(context)
                                .queryParameters['currentCnt']!),
                            "maxCnt": int.parse(GoRouterState.of(context)
                                .queryParameters['maxCnt']!),
                            "sameGender": bool.parse(GoRouterState.of(context)
                                .queryParameters['sameGender']!),
                            "sameAge": bool.parse(GoRouterState.of(context)
                                .queryParameters['sameAge']!),
                            "isPet": bool.parse(GoRouterState.of(context)
                                .queryParameters['isPet']!),
                            "meetPlace": GoRouterState.of(context)
                                .queryParameters['meetPlace'],
                            "types": DataUtils.stringToList(
                                GoRouterState.of(context)
                                    .queryParameters['types']),
                            "places":
                                DataUtils.convertPlaces(courseState.places),
                          });
                          setState(() {
                            isLoading = false;
                          });
                          _showTripCompletionDialog(context);
                        },
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.8)))
                      : Text(
                          '내 여행으로 추가하기',
                          style: !isCheckedTrip
                              ? const TextStyle(
                                  color: LABEL_TEXT_SUB_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0)
                              : const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showTripCompletionDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFF1F1F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '멋진 여행을 추가하셨네요!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: Container(
              width: double.infinity,
              height: 50.0,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1.5, // 세로 줄의 너비
                  ),
                ),
              ),
              child: MaterialButton(
                child: const Text(
                  '홈으로',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  // 여기에 여행을 보러가는 로직을 추가
                  Navigator.of(context).pop();
                  context.go('/');
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
