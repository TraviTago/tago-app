import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/user/model/kako_login_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final loginModel = KakaoLoginModel();
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: true,
          bottom: false,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Logo(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _LoginSubTitle(),
                      const SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () => {context.go('/form1')},
                        child: Image.asset(
                          'asset/img/kakao_login.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
      padding: const EdgeInsets.all(8.0),
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
