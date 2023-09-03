import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tago_app/place/view/place_main_screen.dart';
import 'package:tago_app/trip/view/list/trip_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String backgroundImageUrl =
      'http://tong.visitkorea.or.kr/cms/resource/67/2612467_image2_1.jpg';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          if (_tabController.index == 1)
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  height: 500,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(backgroundImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white
                        ], // 여기서 그라데이션의 색상을 지정합니다.
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                )),
          if (_tabController.index == 0)
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Material(
                  color: _tabController.index == 0
                      ? Colors.white
                      : Colors.transparent,
                  elevation: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      padding: const EdgeInsets.only(left: 30.0),
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                      indicator: const UnderlineTabIndicator(
                        insets: EdgeInsets.symmetric(horizontal: 6.0),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                          width: 3.0,
                          color: Colors.black,
                        ),
                      ),
                      tabs: const <Widget>[
                        Tab(text: '참여하기'),
                        Tab(text: '둘러보기'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      const TripListScreen(),
                      PlaceMainScreen(
                        onImageChange: (newImageUrl) {
                          setState(() {
                            backgroundImageUrl = newImageUrl;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
