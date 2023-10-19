import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/shimmer_box.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/user/component/menu_list.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModelBase? user = ref.watch(userProvider);

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
        child: Column(
          children: [
            if (user is UserModel) _ProfileCard(userModel: user),
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
              onTap: () => {context.push('/withdraw')},
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
            const SizedBox(
              height: 30,
            ),
          ],
        ),
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
        titles: const ['고객센터', '실시간 불편 신고'],
        onTaps: [
          () => {context.go('/customerCenter')},
          () => {context.go('/customerReport')},
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserModel userModel;

  const _ProfileCard({
    required this.userModel,
  });

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
              userModel.imgUrl,
              fit: BoxFit.cover,
              width: 90,
              height: 90,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const ShimmerBox(width: 90.0, height: 90.0);
              },
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
                      userModel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        userModel.mbti,
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
                      "${userModel.ageRange}대",
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: LABEL_TEXT_SUB_COLOR,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DataUtils.genderPrinter(userModel.gender),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: LABEL_TEXT_SUB_COLOR,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => {
                    context.go('/profile'),
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
          () async {
            const url =
                'https://aquamarine-green-f8d.notion.site/4e971784c48c4be19ba73743436afb53';

            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
          () async {
            const url =
                'https://aquamarine-green-f8d.notion.site/af8ffc59bb3a4a368702513e32ca1b25?pvs=4';

            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
          () async {
            const url =
                'https://aquamarine-green-f8d.notion.site/_-adbbda6aaed842af984e2cfcb6264a4f';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
          () async {
            const url =
                'https://aquamarine-green-f8d.notion.site/_-f34052cfc4d84649aa2fb9e082d17335';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
        ],
      ),
    );
  }
}
