import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/login/component/phone_number_field.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:tago_app/user/repository/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool isAllChecked = false;
  bool isServiceChecked = false;
  bool isInfoChecked = false;
  bool isLoading = false;

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

      ref.read(authRepositoryProvider).smsSending(number: formattedNumber);

      setState(() {
        isPhoneNumberEnabled = false;
        showVerificationField = true;
        isVerifyMode = true;
      });
    }
  }

  void updateState(String type) {
    if (type == "all") {
      isAllChecked = !isAllChecked;
      if (isAllChecked) {
        isServiceChecked = true;
        isInfoChecked = true;
      } else {
        isServiceChecked = false;
        isInfoChecked = false;
      }
    } else if (type == "service") {
      isServiceChecked = !isServiceChecked;
      if (isInfoChecked && isServiceChecked) {
        isAllChecked = true;
      } else {
        isAllChecked = false;
      }
    } else {
      isInfoChecked = !isInfoChecked;
      if (isInfoChecked && isServiceChecked) {
        isAllChecked = true;
      } else {
        isAllChecked = false;
      }
    }
  }

  void handleSmsVerify() async {
    // 인증 번호를 확인합니다.
    if (verificationCode.length == 6) {
      String formattedNumber = phoneNumber.replaceAll('-', '');
      try {
        setState(() {
          isLoading = true;
        });
        final smsVerify = await ref
            .read(authRepositoryProvider)
            .smsVerify(number: formattedNumber, code: verificationCode);
        if (smsVerify.isVerify) {
          if (smsVerify.isSignUp) {
            await ref.read(userProvider.notifier).login(
                  number: phoneNumber,
                  userType: "USER",
                );
          } else {
            setState(() {
              isLoading = false;
            });
            _checkPolicy();
          }
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

  void _checkPolicy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: PRIMARY_COLOR,
                            activeColor: Colors.white,
                            side: const BorderSide(
                              width: 1,
                              color: SELECTED_BOX_BG_COLOR,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: isAllChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                updateState("all");
                              });
                            },
                          ),
                          const Text(
                            '약관 전체 동의',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: LABEL_TEXT_COLOR,
                          ),
                          onPressed: () async {
                            const url =
                                'https://aquamarine-green-f8d.notion.site/_-aa5116fda674427d833923196b5da6f4';

                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {}
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: PRIMARY_COLOR,
                        activeColor: Colors.white,
                        side: const BorderSide(
                          width: 1,
                          color: SELECTED_BOX_BG_COLOR,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isServiceChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            updateState("service");
                          });
                        },
                      ),
                      const Text(
                        '(필수) 서비스 이용약관 동의',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontSize: 11.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: PRIMARY_COLOR,
                        activeColor: Colors.white,
                        side: const BorderSide(
                          width: 1,
                          color: SELECTED_BOX_BG_COLOR,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isInfoChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            updateState("info");
                          });
                        },
                      ),
                      const Text(
                        '(필수) 개인정보 수집/이용 및 제3자 제공 동의',
                        style: TextStyle(
                          color: LABEL_TEXT_SUB_COLOR,
                          fontSize: 11.0,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            iconPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            actions: [
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: LABEL_BG_COLOR,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0)),
                        ),
                        onPressed: isAllChecked
                            ? () {
                                context.go(
                                  Uri(
                                    path: '/signup2',
                                    queryParameters: {
                                      'number': phoneNumber,
                                    },
                                  ).toString(),
                                );
                              }
                            : null,
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            color:
                                isAllChecked ? PRIMARY_COLOR : LABEL_TEXT_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
