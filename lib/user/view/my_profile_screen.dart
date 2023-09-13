import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/shimmer_box.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';

class MyProfileScreen extends ConsumerWidget {
  static String get routeName => 'profile';

  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModelBase? user = ref.watch(userProvider);

    return DefaultLayout(
      titleComponet: const Text(
        '프로필 수정',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            if (user is UserModel)
              Expanded(
                flex: 1,
                child: _ProfileBox(userModel: user),
              ),
            if (user is UserModel)
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InfoRow(
                      label: 'MBTI',
                      value: user.mbti,
                      border: true,
                    ),
                    InfoRow(
                      label: '좋아하는 것',
                      value: user.favorites.join(', '),
                      border: true,
                    ),
                    InfoRow(
                      label: '여행스타일',
                      value: user.tripTypes.join('\n'),
                      border: false,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PatchButton(
                      userModel: user,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileBox extends StatelessWidget {
  final UserModel userModel;

  const _ProfileBox({
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(height: 15),
        Text(
          userModel.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${userModel.ageRange}대",
              style: const TextStyle(
                fontSize: 13.0,
                color: LABEL_TEXT_SUB_COLOR,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              DataUtils.genderPrinter(userModel.gender),
              style: const TextStyle(
                fontSize: 13.0,
                color: LABEL_TEXT_SUB_COLOR,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PatchButton extends StatelessWidget {
  final UserModel userModel;

  const PatchButton({
    required this.userModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextButton(
        onPressed: () {
          context.push(
            Uri(path: '/form2', queryParameters: {
              'ageRange': userModel.ageRange.toString(),
              'gender': DataUtils.genderPrinter(userModel.gender),
              'isPatching': "true",
            }).toString(),
          );
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          maximumSize: Size(
            MediaQuery.of(context).size.width,
            45,
          ),
          minimumSize: Size(
            MediaQuery.of(context).size.width,
            45,
          ),
          backgroundColor: LABEL_BG_COLOR,
        ),
        child: const Text(
          '수정하기',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool border;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: border ? LABEL_BG_COLOR : Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: LABEL_TEXT_SUB_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
