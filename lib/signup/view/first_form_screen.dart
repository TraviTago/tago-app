import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';

class FirstFormScreen extends StatefulWidget {
  static String get routeName => 'form1';

  const FirstFormScreen({super.key});

  @override
  State<FirstFormScreen> createState() => _FirstFormScreenState();
}

class _FirstFormScreenState extends State<FirstFormScreen> {
  int? _selectedAgeRange;
  String? _selectedGender;

  int? _getAgeRangeFromString(String ageString) {
    if (ageString == '10대') return 10;
    if (ageString == '20대') return 20;
    if (ageString == '30대') return 30;
    if (ageString == '40대') return 40;
    if (ageString == '50대') return 50;
    if (ageString == '60대') return 60;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String name = GoRouterState.of(context).queryParameters['name']!;
    String imagePath = GoRouterState.of(context).queryParameters['imagePath']!;
    String number = GoRouterState.of(context).queryParameters['number']!;

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                beginPercentage: 0,
                endPercentage: 0.25,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '반가워요!',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '딱 맞는 코스를 추천해드릴게요!',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 나이대는',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 150,
                    child: ButtonGroup(
                      buttonCount: 6,
                      buttonTexts: const [
                        '10대',
                        '20대',
                        '30대',
                        '40대',
                        '50대',
                        '60대'
                      ],
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                      onButtonSelected: (selectedButtons) {
                        // 콜백 구현
                        setState(() {
                          _selectedAgeRange =
                              _getAgeRangeFromString(selectedButtons[0]);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 성별은',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 150,
                    child: ButtonGroup(
                      buttonCount: 2,
                      buttonTexts: const ['남성', '여성'],
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      onButtonSelected: (selectedButtons) {
                        // 콜백 구현
                        setState(() {
                          _selectedGender = selectedButtons[0];
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        _selectedAgeRange == null || _selectedGender == null
                            ? MaterialStateProperty.all(
                                BUTTON_BG_COLOR.withOpacity(0.5))
                            : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed:
                      _selectedAgeRange == null || _selectedGender == null
                          ? null
                          : () {
                              context.push(
                                Uri(
                                  path: '/form2',
                                  queryParameters: {
                                    'ageRange': _selectedAgeRange.toString(),
                                    'gender': _selectedGender,
                                    'isPatching': "false",
                                    'name': name,
                                    'imagePath': imagePath,
                                    'number': number,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
