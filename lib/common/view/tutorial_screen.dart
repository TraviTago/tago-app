import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class TutorialScreen extends StatelessWidget {
  static String get routeName => 'tutorial';

  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        bottom: true,
        child: Center(
          child: SizedBox(
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        child: Image.asset(
                          'asset/img/tutorial/tutorial_${index + 1}.png',
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                    indicatorLayout: PageIndicatorLayout.SCALE,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        size: 10,
                        activeColor: PRIMARY_COLOR,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                    itemCount: 7,
                    scale: 1,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 10,
                  right: 10,
                  child: ElevatedButton(
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
                            MaterialStateProperty.all(PRIMARY_COLOR)),
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text(
                      '타고 이용하러가기',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                    ),
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
