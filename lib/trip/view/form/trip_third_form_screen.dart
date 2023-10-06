import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class TripThirdFormScreen extends StatefulWidget {
  const TripThirdFormScreen({super.key});

  static String get routeName => 'tripForm3';

  @override
  State<TripThirdFormScreen> createState() => _TripThirdFormScreenState();
}

class _TripThirdFormScreenState extends State<TripThirdFormScreen> {
  List<String> selectedGenderButtons = [];
  List<String> selectedAgeButtons = [];
  List<String> selectedPetButtons = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
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
                  ProgressBar(beginPercentage: 0.32, endPercentage: 0.48),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    '원하는 조건을 선택해주세요',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '내 여행메이트는 이랬으면 좋겠어요!',
                    style: TextStyle(
                      color: LABEL_TEXT_SUB_COLOR,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '성별은',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: screenWidth / (4 * 2),
                        child: ButtonGroup(
                          fontSize: 14.0,
                          buttonCount: 2,
                          buttonTexts: tripThirdFormBtnText[0],
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          onButtonSelected: (selected) {
                            setState(
                              () {
                                selectedGenderButtons = selected;
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '나이대는',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                              height: screenWidth / (4 * 2),
                              child: ButtonGroup(
                                fontSize: 14.0,
                                buttonCount: 2,
                                buttonTexts: tripThirdFormBtnText[1],
                                crossAxisCount: 2,
                                childAspectRatio: 4,
                                onButtonSelected: (selected) {
                                  setState(() {
                                    selectedAgeButtons = selected;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '반려동물은',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: screenWidth / (4 * 2),
                            child: ButtonGroup(
                              fontSize: 14.0,
                              buttonCount: 2,
                              buttonTexts: tripThirdFormBtnText[2],
                              crossAxisCount: 2,
                              childAspectRatio: 4,
                              onButtonSelected: (selected) {
                                setState(() {
                                  selectedPetButtons = selected;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: selectedAgeButtons.isEmpty ||
                            selectedGenderButtons.isEmpty ||
                            selectedPetButtons.isEmpty
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: selectedAgeButtons.isEmpty ||
                          selectedGenderButtons.isEmpty ||
                          selectedPetButtons.isEmpty
                      ? null
                      : () {
                          context.push(
                            Uri(
                              path: '/tripForm4',
                              queryParameters: {
                                'dateTime': GoRouterState.of(context)
                                    .queryParameters['dateTime'],
                                'currentCnt': GoRouterState.of(context)
                                    .queryParameters['currentCnt'],
                                'maxCnt': GoRouterState.of(context)
                                    .queryParameters['maxCnt'],
                                'sameGender': selectedGenderButtons[0] ==
                                        tripThirdFormBtnText[0][0]
                                    ? "true"
                                    : "false",
                                'sameAge': selectedAgeButtons[0] ==
                                        tripThirdFormBtnText[1][0]
                                    ? "true"
                                    : "false",
                                'isPet': selectedPetButtons[0] ==
                                        tripThirdFormBtnText[2][0]
                                    ? "true"
                                    : "false",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
