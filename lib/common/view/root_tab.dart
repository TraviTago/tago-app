import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/view/home_screen.dart';
import 'package:tago_app/user/view/my_page_screen.dart';
import 'package:tago_app/user/view/my_trip_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);
  static String get routeName => 'home';

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.black,
        iconSize: 28,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Image.asset(
                'asset/img/menu/home.png',
                width: 28,
                height: 28,
                color: PRIMARY_COLOR,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Image.asset(
                'asset/img/menu/home.png',
                width: 28,
                height: 28,
                color: Colors.black,
              ),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 7.0),
              child: Image.asset(
                'asset/img/menu/map.png',
                width: 26,
                height: 26,
                color: PRIMARY_COLOR,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 7.0),
              child: Image.asset(
                'asset/img/menu/map.png',
                width: 26,
                height: 26,
                color: Colors.black,
              ),
            ),
            label: '내여행',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Image.asset(
                'asset/img/menu/my.png',
                width: 28,
                height: 28,
                color: PRIMARY_COLOR,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Image.asset(
                'asset/img/menu/my.png',
                width: 28,
                height: 28,
                color: Colors.black,
              ),
            ),
            label: '마이페이지',
          ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomeScreen(),
          MyTripScreen(),
          MyPageScreen(),
        ],
      ),
    );
  }
}
