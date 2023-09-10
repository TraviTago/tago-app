import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/login/component/custom_text_form_field.dart';
import 'package:tago_app/login/model/kako_login_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';
  final loginModel = KakaoLoginModel();
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SafeArea(
            top: true,
            bottom: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const _Logo(),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요',
                    onChanged: (String value) {
                      username = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요',
                    obscureText: true,
                    onChanged: (String value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 100.0,
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
                      backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                      backgroundColor:
                          MaterialStateProperty.all(LABEL_BG_COLOR),
                    ),
                    onPressed: () {
                      context.push('/signup');
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '기사님으로 로그인하기',
                          style: TextStyle(
                            color: LABEL_TEXT_SUB_COLOR,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 110,
      ),
      child: Image.asset(
        'asset/img/logo_red.png',
        width: MediaQuery.of(context).size.width / 2,
      ),
    );
  }
}

class _LoginSubTitle extends StatelessWidget {
  const _LoginSubTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      '카카오톡으로 간편하게 로그인하세요 !',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.65),
      ),
    );
  }
}
