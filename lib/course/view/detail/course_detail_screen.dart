import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/course/view/detail/course_detail_map_screen.dart';
import 'package:tago_app/course/view/detail/course_detail_overview_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  static String get routeName => 'courseDetail';

  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "aa",
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                elevation: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    padding: const EdgeInsets.only(left: 20.0),
                    controller: _tabController,
                    labelColor: PRIMARY_COLOR,
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                    indicator: const UnderlineTabIndicator(
                      insets: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 5.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                        width: 3.0,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                    tabs: const <Widget>[
                      Tab(text: '코스보기'),
                      Tab(text: '지도로보기'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    CourseDetailOverViewScreen(),
                    CourseDetailMapScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
