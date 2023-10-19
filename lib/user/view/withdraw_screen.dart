import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/user/provider/auth_provider.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  static String get routeName => 'withdraw';

  const WithdrawScreen({super.key});
  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  bool isChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '타고 회원 탈퇴',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '타고를 탈퇴하면,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  '내 프로필, 내 여행 목록,  그 외 사용자가 설정한 모든 정보가 사라지고 복구가 불가능합니다.\n참여 중인 여행이 있다면 모두 취소 한 후 탈퇴를 시도해주세요.\n타고가 저장한 회원님의 개인정보 (전화번호, 이름 등)은 탈퇴 즉시 삭제됩니다.',
                  style: TextStyle(
                    color: LABEL_TEXT_SUB_COLOR,
                    height: 1.5,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: PRIMARY_COLOR,
                      side: const BorderSide(
                        width: 1,
                        color: SELECTED_BOX_BG_COLOR,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue ?? false;
                        });
                      },
                    ),
                    const Text(
                      '위 유의사항을 모두 확인하였고, 탈퇴를 진행합니다.',
                      style: TextStyle(
                        color: LABEL_TEXT_SUB_COLOR,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: isChecked
                        ? MaterialStateProperty.all(PRIMARY_COLOR)
                        : MaterialStateProperty.all(LABEL_BG_COLOR),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await ref.read(authProvider.notifier).withdraw();
                  },
                  child: Text(
                    '탈퇴하기',
                    style: TextStyle(
                        color: isChecked ? Colors.white : LABEL_TEXT_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
