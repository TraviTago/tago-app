import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CustomerServiceCenterScreen extends StatelessWidget {
  static String get routeName => 'customerCenter';

  const CustomerServiceCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      titleComponet: const Text(
        '고객센터',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '안녕하세요\n타고 고객센터 입니다',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  '궁금한 점이 있다면 부담없이 전화주세요!\n영업시간 내에 상담원이 친절하게 답변해 드립니다.',
                  style: TextStyle(
                    color: LABEL_TEXT_SUB_COLOR,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  '(영업시간) 9:00-17:00',
                  style: TextStyle(
                    color: LABEL_TEXT_COLOR,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: LABEL_BG_COLOR,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '고객센터',
                          ),
                          Text(
                            '0502-1930-1996',
                          ),
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '택시문의',
                        ),
                        Text(
                          '010-9880-7611',
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SpacerContainer(),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '자주 묻는 질문이 궁금하다면?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    RedirectButton(
                      buttonType: "question",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '여행 중 문제가 생겼다면?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    RedirectButton(
                      buttonType: "report",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RedirectButton extends StatelessWidget {
  final String buttonType;
  const RedirectButton({
    required this.buttonType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (buttonType == "question") {
          context.push('/customerQuestion');
        } else if (buttonType == "report") {
          context.push('/customerReport');
        }
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: LABEL_BG_COLOR,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          buttonType == "report" ? "실시간 불편 신고 바로가기" : '보러가기',
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
