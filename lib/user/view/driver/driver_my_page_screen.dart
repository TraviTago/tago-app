import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/component/shimmer_box.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/user/component/menu_list.dart';
import 'package:tago_app/user/model/driver_user_model.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMyPageScreen extends ConsumerWidget {
  const DriverMyPageScreen({Key? key}) : super(key: key);

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
            if (user is DriverUserModel) _DriverProfileCard(userModel: user),
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
          ],
        ),
      ),
    );
  }
}

class _DriverProfileCard extends StatelessWidget {
  final DriverUserModel userModel;

  const _DriverProfileCard({
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
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                      '기사님',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: PRIMARY_COLOR,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  '항상 안전한 운행 부탁드려요 기사님\n오늘도 활기찬 하루 되세요 :-)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: LABEL_TEXT_SUB_COLOR,
                      fontSize: 13.0,
                      height: 1.3),
                ),
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
                'https://aquamarine-green-f8d.notion.site/_-aa5116fda674427d833923196b5da6f4';

            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
          () async {
            const url =
                'https://aquamarine-green-f8d.notion.site/_-aa5116fda674427d833923196b5da6f4';

            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {}
          },
        ],
      ),
    );
  }
}
