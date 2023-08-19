import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/signup/model/sign_up_model.dart';
import 'package:tago_app/user/component/menu_list.dart';
import 'package:tago_app/user/provider/user_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpModel signUpModel = SignUpModel(
      ageRange: 20,
      gender: "여성",
      mbti: "ENFP",
      favorites: ["INSTAGRAM"],
      tripTypes: ["SLOW_LAZY"],
    );

    return DefaultLayout(
      titleComponetWithoutPop: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            '마이페이지',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: FutureBuilder<User>(
          future: UserApi.instance.me(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                var profile = snapshot.data!.kakaoAccount!.profile!;
                return Column(
                  children: [
                    _ProfileCard(profile: profile, signUpModel: signUpModel),
                    const SpacerContainer(),
                    _ServiceCenter(),
                    const SpacerContainer(),
                    _Information(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextButton(
                        onPressed: () async {
                          await ref.read(userProvider.notifier).logout();
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(137, 35),
                          foregroundColor: LABEL_TEXT_SUB_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: LABEL_BG_COLOR,
                        ),
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(
                            color: LABEL_TEXT_SUB_COLOR,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        //TOFIX: 탈퇴하기
                      },
                      child: const Text(
                        '탈퇴하기',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final Profile profile;
  final SignUpModel signUpModel;

  const _ProfileCard({required this.profile, required this.signUpModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              profile.profileImageUrl!,
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      profile.nickname!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        signUpModel.mbti,
                        style: const TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${signUpModel.ageRange}대",
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: LABEL_TEXT_SUB_COLOR,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      signUpModel.gender,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: LABEL_TEXT_SUB_COLOR,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => {
                    //TOFIX: 로그아웃
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(155, 25),
                    foregroundColor: LABEL_TEXT_SUB_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: LABEL_BG_COLOR,
                  ),
                  child: const Text(
                    '프로필 수정하기',
                    style: TextStyle(
                      color: LABEL_TEXT_SUB_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: MenuList(
        titles: const ['자주 묻는 질문', '고객센터'],
        onTaps: [
          () => {context.go('/tripDetail')},
          () => {},
        ],
      ),
    );
  }
}

class _Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: MenuList(
        titles: const [
          '타고소개',
          '택시 투어 소개',
          '서비스 이용약관',
          '개인 정보 처리 방침',
        ],
        onTaps: [
          () => {},
          () => {},
          () => {},
          () => {},
        ],
      ),
    );
  }
}
