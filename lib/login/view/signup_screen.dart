import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class SignupScreen extends StatefulWidget {
  static String get routeName => 'signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool phoneCheckSended = false;
  String email = '';
  String password = '';
  String name = '';
  String phoneNumber = '';
  String phoneNumberCheck = '';
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isNameValid = true;
  bool isPhoneNumberValid = true;
  bool isPhoneNumberCheckValid = true;

  String? errorText;
  bool _areAllFieldsValid() {
    return isEmailValid && isPasswordValid && isNameValid && isPhoneNumberValid;
  }

  void _updateErrorText() {
    List<String> errors = [];
    if (!isEmailValid) {
      errors.add('올바르지 않은 이메일 형식입니다');
    }
    if (!isPasswordValid) {
      errors.add('숫자, 영문, 특수문자 8~16자로 입력해주세요');
    }
    if (!isNameValid) {
      errors.add('이름을 제대로 입력해주세요');
    }
    if (!isPhoneNumberValid) {
      errors.add('올바르지 않은 전화번호 형식입니다');
    }
    if (phoneCheckSended && !isPhoneNumberCheckValid) {
      errors.add('올바르지 않은 인증번호 형식입니다');
    }
    errorText = errors.join('\n');
  }

  // 이메일 유효성 검사 함수
  void _validateEmail(String value) {
    if (value.isEmpty || !value.contains('@')) {
      isEmailValid = false;
    } else {
      isEmailValid = true;
      errorText = null;
    }
    setState(() {
      _updateErrorText();
    });
    email = value;
  }

  // 비밀번호 유효성 검사 함수
  void _validatePassword(String value) {
    RegExp passwordPattern =
        RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,16}$');
    if (!passwordPattern.hasMatch(value) || value.isEmpty) {
      isPasswordValid = false;
    } else {
      isPasswordValid = true;
      errorText = null;
    }
    setState(() {
      _updateErrorText();
    });
    password = value;
  }

  // 이름 유효성 검사 함수
  void _validateName(String value) {
    if (value.isEmpty) {
      isNameValid = false;
    } else {
      isNameValid = true;
      errorText = null;
    }
    setState(() {
      _updateErrorText();
    });
    name = value;
  }

  // 전화번호 유효성 검사 함수
  void _validatePhoneNumber(String value) {
    RegExp phonePattern = RegExp(r'^\d{11}$');
    if (!phonePattern.hasMatch(value) || value.isEmpty) {
      isPhoneNumberValid = false;
    } else {
      isPhoneNumberValid = true;
      errorText = null;
    }
    setState(() {
      _updateErrorText();
    });
    phoneNumber = value;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        titleComponet: const Text(
          '회원가입',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: PRIMARY_COLOR,
            fontSize: 20,
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    CustomSignupFormField(
                        hintText: '이메일',
                        icon: Icons.email_outlined,
                        obscureText: false,
                        onChanged: _validateEmail,
                        valid: isEmailValid,
                        enabled: !phoneCheckSended),
                    CustomSignupFormField(
                        hintText: '비밀번호',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged: _validatePassword,
                        valid: isPasswordValid,
                        enabled: !phoneCheckSended),
                    CustomSignupFormField(
                        hintText: '이름',
                        icon: Icons.person,
                        onChanged: _validateName,
                        obscureText: false,
                        valid: isNameValid,
                        enabled: !phoneCheckSended),
                    CustomSignupFormField(
                        hintText: '휴대폰번호',
                        icon: Icons.phone_iphone_outlined,
                        onChanged: _validatePhoneNumber,
                        obscureText: false,
                        valid: isPhoneNumberValid,
                        enabled: !phoneCheckSended),
                    if (phoneCheckSended == true)
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomSignupFormField(
                              hintText: '인증번호',
                              onChanged: (phoneNumberCheck) =>
                                  this.phoneNumberCheck = phoneNumberCheck,
                              obscureText: false,
                              valid: isPhoneNumberCheckValid,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            PRIMARY_COLOR),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return null;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    //TOFIX: 인증번호 재전송 로직
                                  },
                                  child: const Text(
                                    '재전송',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    if (errorText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            errorText!,
                            style: const TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width, 45)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      _validateEmail(email);
                      _validateName(name);
                      _validatePassword(password);
                      _validatePhoneNumber(phoneNumber);
                      if (!_areAllFieldsValid()) {
                        return;
                      }
                      //TOFIX: 문자 인증 요청.
                      setState(() {
                        phoneCheckSended = true;
                      });
                    },
                    child: Text(
                      phoneCheckSended == false ? '인증 요청' : '회원 가입',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ));
  }
}

class CustomSignupFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool valid;
  final IconData? icon;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  const CustomSignupFormField({
    required this.onChanged,
    required this.valid,
    this.icon,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    super.key,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: LABEL_BG_COLOR,
        width: 1.0,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          if (icon != null)
            Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  color: LABEL_TEXT_COLOR,
                )),
          Expanded(
            flex: 6,
            child: TextFormField(
              enabled: enabled,
              cursorColor: PRIMARY_COLOR,
              //비밀번호 입력할 때
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: hintText,
                errorText: errorText,
                hintStyle: const TextStyle(
                  color: LABEL_TEXT_COLOR,
                  fontSize: 15.0,
                ),
                fillColor: Colors.white,
                filled: true,
                border: baseBorder,
                focusedBorder: baseBorder.copyWith(
                  borderSide: baseBorder.borderSide.copyWith(
                    color: PRIMARY_COLOR,
                  ),
                ),
                enabledBorder: baseBorder,
              ),
            ),
          ),
          if (valid == false)
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: PRIMARY_COLOR,
                )),
        ],
      ),
    );
  }
}
