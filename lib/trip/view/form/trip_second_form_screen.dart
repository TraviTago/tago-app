import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/form/person_counter.dart';

class TripSecondFormScreen extends StatefulWidget {
  const TripSecondFormScreen({Key? key}) : super(key: key);
  static String get routeName => 'tripForm2';

  @override
  _TripSecondFormScreenState createState() => _TripSecondFormScreenState();
}

class _TripSecondFormScreenState extends State<TripSecondFormScreen> {
  int totalNum = 1;
  int maxNum = 4;
  int maxNumWithTotal = 4;
  bool isPrivateTrip = false;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressBar(beginPercentage: 0.16, endPercentage: 0.32),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    '여행의 전체 인원을\n입력해주세요',
                    style: TextStyle(
                      fontSize: 23,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                '희망 택시정원',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            PersonCounter(
                              min: 1,
                              max: 8,
                              count: maxNum,
                              textColor: maxNum % 4 == 0
                                  ? PRIMARY_COLOR
                                  : Colors.black, // 조건에 따른 색상 설정
                              onIncrement: () {
                                setState(() {
                                  maxNum++;
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  if (maxNum > 1) maxNum--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '일반은 최대 4인, 대형은 최대 8인 승차가능',
                    style: TextStyle(
                      fontSize: 14,
                      color: LABEL_TEXT_COLOR,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 45)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(BUTTON_BG_COLOR),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  context.push(
                    Uri(
                      path: '/tripForm3',
                      queryParameters: {
                        'dateTime': GoRouterState.of(context)
                            .queryParameters['dateTime'],
                        'currentCnt': "1",
                        'maxCnt': maxNum.toString()
                      },
                    ).toString(),
                  );
                },
                child: const Text(
                  '다음',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
