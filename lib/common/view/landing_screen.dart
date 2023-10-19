import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class LandingScreen extends StatelessWidget {
  static String get routeName => 'landing';

  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            const Center(
              child: _Logo(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                        '시작하기',
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
                          onPressed: () {
                            context.push('/driverLogin');
                          },
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
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/img/logo_red.png',
          width: MediaQuery.of(context).size.width / 4,
        ),
        const LandingSwiper(),
      ],
    );
  }
}

class LandingSwiper extends StatelessWidget {
  const LandingSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.width * 1.0,
      child: Swiper(
        autoplay: true,
        loop: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'asset/img/onBoarding/${index + 1}.png',
            width: MediaQuery.of(context).size.width,
          );
        },
        indicatorLayout: PageIndicatorLayout.SCALE,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6,
            activeColor: PRIMARY_COLOR,
            color: SELECTED_BOX_BG_COLOR,
          ),
        ),
        itemCount: 4,
        scale: 1,
      ),
    );
  }
}
