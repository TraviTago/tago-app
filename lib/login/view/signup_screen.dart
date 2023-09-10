import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/login/component/custom_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  static String get routeName => 'signup';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String password = '';
    String passwordCheck = '';
    String phoneNumber = '';
    String phoneNumberCheck = '';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
          child: Column(
            children: [
              _SignupForm(
                formField: '이름',
                textField: '이름을 입력해주세요',
                obscureText: false,
                value: name,
              ),
              _SignupForm(
                formField: '비밀번호',
                textField: '숫자, 영문, 특수문자 8~16자 입력',
                obscureText: true,
                value: password,
              ),
              _SignupForm(
                formField: '비밀번호 확인',
                textField: '비밀번호 확인',
                obscureText: true,
                value: passwordCheck,
              ),
              _SignupForm(
                formField: '휴대폰번호',
                textField: '휴대폰번호 입력',
                value: phoneNumber,
                obscureText: false,
                phoneChecking: true,
              ),
              _SignupForm(
                formField: '인증번호',
                textField: '숫자 6자리 입력 ',
                obscureText: false,
                value: phoneNumberCheck,
              ),
            ],
          ),
        ));
  }
}

class _SignupForm extends StatefulWidget {
  final String formField;
  final String textField;
  final String value;
  final bool phoneChecking;
  final bool obscureText;
  const _SignupForm({
    required this.formField,
    required this.textField,
    required this.value,
    required this.obscureText,
    this.phoneChecking = false,
  });

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  @override
  Widget build(BuildContext context) {
    String? errorText;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 6.0,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  widget.formField,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              hintText: widget.textField,
              obscureText: widget.obscureText,
              onChanged: (String value) {
                if (widget.formField == '비밀번호') {
                  setState(() {
                    errorText = validatePassword(value);
                  });
                }
              },
            ),
          ),
          if (widget.phoneChecking)
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(LABEL_BG_COLOR),
                  ),
                  onPressed: () {},
                  child: const Text(
                    '인증번호 전송',
                    style: TextStyle(
                        color: LABEL_TEXT_SUB_COLOR,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String? validatePassword(String password) {
  const pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
  final regex = RegExp(pattern);

  if (!regex.hasMatch(password)) {
    return '숫자, 영문, 특수문자 8~16자로 입력해주세요';
  } else {
    return '가능한 비밀번호입니다';
  }
}
