import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/signup/model/sign_up_model.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.baseline, // Add this
                                textBaseline:
                                    TextBaseline.alphabetic, // And this
                                children: [
                                  Baseline(
                                    baselineType: TextBaseline.alphabetic,
                                    baseline: 0, // This ensures alignment
                                    child: Text(
                                      profile.nickname!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Baseline(
                                    baselineType: TextBaseline.alphabetic,
                                    baseline: 0, // This ensures alignment
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
                                  const SizedBox(
                                      width:
                                          5), // Space between ageRange and gender
                                  Text(
                                    signUpModel.gender,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: LABEL_TEXT_SUB_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () => {},
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(LABEL_BG_COLOR),
                                  foregroundColor: MaterialStateProperty.all(
                                      LABEL_TEXT_SUB_COLOR),
                                ),
                                child: const Text(
                                  '프로필 수정하기',
                                  style: TextStyle(
                                      color: LABEL_TEXT_SUB_COLOR,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
