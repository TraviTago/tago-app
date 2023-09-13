import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class LandingScreen extends StatelessWidget {
  static String get routeName => 'landing';

  const LandingScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Center(
                  child: _Logo(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width, 45)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(PRIMARY_COLOR),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          context.push('/login');
                        },
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ],
                  ),
                ),
              ),
            ],
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
    return Image.asset(
      'asset/img/logo_red.png',
      width: MediaQuery.of(context).size.width / 2,
    );
  }
}
