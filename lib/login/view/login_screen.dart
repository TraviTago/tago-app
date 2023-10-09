import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/login/component/phone_number_field.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:tago_app/user/repository/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
                '안녕하세요!\n휴대폰 번호로 로그인 해주세요',
                style: TextStyle(
                  height: 1.3,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PinFieldAutoFill(
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        decoration: UnderlineDecoration(
                          gapSpace: 20.0,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: LABEL_TEXT_SUB_COLOR,
                            fontWeight: FontWeight.w700,
                          ),
                          colorBuilder: FixedColorBuilder(
                              verificationCode.length == 6
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.3)),
                        ),
                        currentCode: verificationCode,
                        onCodeChanged: (code) {
                          setState(() {
                            verificationCode = code!;
                          });
                        },
                        codeLength: 6, // 인증번호의 길이를 설정합니다.
                      ),
                      if (errorText != null)
                        const SizedBox(
                          height: 10.0,
                        ),
                      if (errorText != null)
                        SizedBox(
                          child: Text(
                            errorText!,
                            style: const TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                    ],
                  ),
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

      //TOFIX: DEMO 아이디
      if (formattedNumber == "01011111111") {
        setState(() {
          isPhoneNumberEnabled = false;
          showVerificationField = true;
          isVerifyMode = true;
        });
      } else {
        ref.read(authRepositoryProvider).smsSending(number: formattedNumber);

        setState(() {
          isPhoneNumberEnabled = false;
          showVerificationField = true;
          isVerifyMode = true;
        });
      }
    }
  }

  void handleSmsVerify() async {
    // 인증 번호를 확인합니다.
    if (verificationCode.length == 6) {
      String formattedNumber = phoneNumber.replaceAll('-', '');
      //TOFIX: DEMO 아이디
      if (formattedNumber == "01011111111") {
        if (verificationCode == "000000") {
          await ref
              .read(userProvider.notifier)
              .login(number: phoneNumber, userType: "USER");
        }
      } else {
        try {
          final smsVerify = await ref
              .read(authRepositoryProvider)
              .smsVerify(number: formattedNumber, code: verificationCode);
          if (smsVerify.verify) {
            await ref
                .read(userProvider.notifier)
                .login(number: phoneNumber, userType: "USER");
          }
        } catch (e) {
          //1. 인증번호 틀렸을 경우
          errorText = "인증번호를 다시 입력해주세요";
          setState(() {});
          //2. 시간초과일 경우
        }
      }
    }
  }
}
