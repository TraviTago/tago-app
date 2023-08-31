import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/trip_recommend_card.dart';

class TripCompleteScreen extends StatefulWidget {
  static String get routeName => 'tripComplete';

  const TripCompleteScreen({super.key});

  @override
  State<TripCompleteScreen> createState() => _TripCompleteScreenState();
}

bool isCheckedTrip = false;

class _TripCompleteScreenState extends State<TripCompleteScreen> {
  @override
  @override
  Widget build(BuildContext context) {
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
                      fontWeight: FontWeight.w900,
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
                  TripRecommendCard.fromModel(
                    model: tripData,
                  ),
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
                          fontSize: 13.0,
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
                      : () {
                          //TOFIX: 코스 추가 로직
                          context.go('/');
                        },
                  child: Text(
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
