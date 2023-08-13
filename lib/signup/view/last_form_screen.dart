import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/user/model/sign_up_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';

class LastFormScreen extends ConsumerStatefulWidget {
  static String get routeName => 'form4';

  const LastFormScreen({super.key});

  @override
  ConsumerState<LastFormScreen> createState() => _LastFormScreenState();
}

class _LastFormScreenState extends ConsumerState<LastFormScreen> {
  List<String> _selectedTripTypes = [];

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 100.0,
              ),
              Expanded(
                child: ButtonGroup(
                  isMultipleSelection: true,
                  buttonCount: 6,
                  mainAxisSpacing: 25.0,
                  crossAxisSpacing: 15.0,
                  buttonTexts: const [
                    '느긋 하고 여유롭게',
                    '부지런히 이곳저곳!',
                    '최신유행은 가봐야지',
                    '사람이 많지않은 좋은곳',
                    '여행에서 음식은 중요해',
                    '음식은 크게 중요하지 않아'
                  ],
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  onButtonSelected: (selectedButtons) {
                    // 콜백 구현
                    setState(() {
                      _selectedTripTypes = selectedButtons;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: _selectedTripTypes.isEmpty
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: _selectedTripTypes.isEmpty
                      ? null
                      : () async {
                          // 카카오 로그인 성공 여부
                          var queryParams =
                              GoRouterState.of(context).queryParameters;
                          await ref.read(userProvider.notifier).signUp(
                                // TOFIX: 회원가입 모델 임시
                                signUpModel: SignUpModel(
                                  ageRange: int.tryParse(queryParams[
                                      'ageRange']!)!, // 기본 값 0으로 설정, 적절한 값을 설정해야 할 수도 있습니다.
                                  gender: "MALE",
                                  mbti: "ENFP",
                                  favorites: ["INSTAGRAM"],
                                  tripTypes: ["SLOW_LAZY"],
                                ),
                              );
                        },
                  child: const Text(
                    '시작하기',
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
