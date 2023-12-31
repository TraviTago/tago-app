import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/user/provider/user_provider.dart';

class LastFormScreen extends ConsumerStatefulWidget {
  static String get routeName => 'form4';

  const LastFormScreen({super.key});

  @override
  ConsumerState<LastFormScreen> createState() => _LastFormScreenState();
}

class _LastFormScreenState extends ConsumerState<LastFormScreen> {
  String selectedTripType1 = "";
  String selectedTripType2 = "";
  String selectedTripType3 = "";
  final List<String> _selectedTripTypes = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isAllSelected = selectedTripType1 != "" &&
        selectedTripType2 != "" &&
        selectedTripType3 != "";

    bool isPatching =
        GoRouterState.of(context).queryParameters['isPatching'] == "true";
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                beginPercentage: 0.75,
                endPercentage: 1.0,
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                '주로 어떤 여행을 하시나요?',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ButtonGroup(
                      fontSize: 13.0,
                      buttonCount: 2,
                      mainAxisSpacing: 0.0,
                      isAdjacent: true,
                      radius: 10.0,
                      crossAxisSpacing: 0.0,
                      buttonTexts: const [
                        '부지런히 이곳저곳!',
                        '느긋하고 여유롭게',
                      ],
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      onButtonSelected: (selectedButtons) {
                        // 콜백 구현
                        setState(() {
                          selectedTripType1 = selectedButtons[0];
                        });
                      },
                    ),
                    const Positioned(
                      top: 6.0,
                      child: SizedBox(
                        height: 50,
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: LABEL_TEXT_COLOR,
                          dashGapLength: 4.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ButtonGroup(
                      fontSize: 12.0,
                      buttonCount: 2,
                      mainAxisSpacing: 0.0,
                      radius: 10.0,
                      crossAxisSpacing: 0.0,
                      isAdjacent: true,
                      buttonTexts: const [
                        '여행에서 음식은 중요해',
                        '음식은 크게 중요하지 않아',
                      ],
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      onButtonSelected: (selectedButtons) {
                        // 콜백 구현
                        setState(() {
                          selectedTripType2 = selectedButtons[0];
                        });
                      },
                    ),
                    const Positioned(
                      top: 6.0,
                      child: SizedBox(
                        height: 50,
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: LABEL_TEXT_COLOR,
                          dashGapLength: 4.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ButtonGroup(
                      fontSize: 13.0,
                      buttonCount: 2,
                      radius: 10.0,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      isAdjacent: true,
                      buttonTexts: const [
                        '최신유행은 가봐야지',
                        '사람이 많지않은 좋은 곳',
                      ],
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      onButtonSelected: (selectedButtons) {
                        // 콜백 구현
                        setState(() {
                          selectedTripType3 = selectedButtons[0];
                        });
                      },
                    ),
                    const Positioned(
                      top: 6.0,
                      child: SizedBox(
                        height: 50,
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: LABEL_TEXT_COLOR,
                          dashGapLength: 4.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: !isAllSelected
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: !isAllSelected
                      ? null
                      : () async {
                          _selectedTripTypes.addAll([
                            selectedTripType1,
                            selectedTripType2,
                            selectedTripType3
                          ]);

                          var queryParams =
                              GoRouterState.of(context).queryParameters;

                          if (isPatching) {
                            setState(() {
                              isLoading = true;
                            });
                            await ref.read(userProvider.notifier).patchProfile(
                                  mbti: queryParams['mbti']!,
                                  favorites:
                                      queryParams['favorites']!.split(','),
                                  tripTypes: _selectedTripTypes,
                                );
                            setState(() {
                              isLoading = false;
                            });
                            context.go('/profile');
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            await ref.read(userProvider.notifier).signUp(
                                  ageRange:
                                      int.tryParse(queryParams['ageRange']!)!,
                                  gender: queryParams['gender']!,
                                  mbti: queryParams['mbti']!,
                                  favorites:
                                      queryParams['favorites']!.split(','),
                                  name: queryParams['name']!,
                                  number: queryParams['number']!,
                                  imgUrl: queryParams['imagePath']!,
                                  tripTypes: _selectedTripTypes,
                                );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                  child: isLoading
                      ? SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.8))),
                        )
                      : Text(
                          isPatching ? '수정하기' : '저장하기',
                          style: const TextStyle(
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
