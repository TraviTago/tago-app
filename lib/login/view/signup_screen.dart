import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/login/component/phone_number_field.dart';
import 'package:tago_app/user/repository/auth_repository.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signup';

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  String phoneNumber = "";
  String verificationCode = "";
  bool isPhoneNumberEnabled = true;
  bool showVerificationField = false;
  bool isVerifyMode = false;
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      titleComponet: const Text(
        '',
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '안녕하세요!\n휴대폰 번호로 회원가입 해주세요',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                '휴대폰 번호는 안전하게 보관되고 공개되지않아요',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              PhoneNumberField(
                hintText: "휴대폰번호 (- 없이 숫자만 입력)",
                isPhoneNumber: true,
                enabled: isPhoneNumberEnabled,
                valid: true,
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone;
                  });
                },
              ),
              if (showVerificationField)
                PhoneNumberField(
                  hintText: "인증번호 6자리 입력",
                  isPhoneNumber: false,
                  valid: true,
                  errorText: errorText,
                  onChanged: (phone) {
                    setState(() {
                      verificationCode = phone;
                    });
                  },
                ),
              const SizedBox(
                height: 30.0,
              ),
              if (!isVerifyMode)
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 40)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(LABEL_BG_COLOR),
                  ),
                  onPressed: handleSmsSending,
                  child: Text(
                    '인증문자 받기',
                    style: TextStyle(
                        color: phoneNumber.length == 13
                            ? PRIMARY_COLOR
                            : LABEL_TEXT_COLOR,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                ),
              if (isVerifyMode)
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
                    backgroundColor: verificationCode.length == 6
                        ? MaterialStateProperty.all(PRIMARY_COLOR)
                        : MaterialStateProperty.all(LABEL_BG_COLOR),
                  ),
                  onPressed: handleSmsVerify,
                  child: Text(
                    '다음',
                    style: TextStyle(
                        color: verificationCode.length == 6
                            ? Colors.white
                            : LABEL_TEXT_COLOR,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSmsSending() {
    if (phoneNumber.length == 13) {
      String formattedNumber = phoneNumber.replaceAll('-', '');

      ref.read(authRepositoryProvider).smsSending(number: formattedNumber);

      setState(() {
        isPhoneNumberEnabled = false;
        showVerificationField = true;
        isVerifyMode = true;
      });
    }
  }

  void handleSmsVerify() async {
    // 인증 번호를 확인합니다.
    if (verificationCode.length == 6) {
      String formattedNumber = phoneNumber.replaceAll('-', '');
      try {
        final smsVerify = await ref
            .read(authRepositoryProvider)
            .smsVerify(number: formattedNumber, code: verificationCode);
        if (smsVerify.verify) {
          //문자 인증 성공일 경우
          context.go(
            Uri(
              path: '/form1',
              queryParameters: {
                'number': phoneNumber,
              },
            ).toString(),
          );
          //TODO: 문자 인증 성공이지만 이미 회원일 경우: 로그인 시켜서 홈으로
        }
      } catch (e) {
        //1. 인증번호 틀렸을 경우
        setState(() {
          errorText = "인증번호를 다시 입력해주세요";
        });
        //2. 시간초과일 경우
      }
    }
  }
}