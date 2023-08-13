import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
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
  //TOFIX
  final detailModel = courseDetailData;

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
      titleComponet: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              detailModel.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            _PersonLabel(
              curNum: detailModel.curNum,
              maxNum: detailModel.maxNum,
            ),
          ],
        ),
      ),
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
                  children: [
                    CourseDetailOverViewScreen(
                      detailModel: detailModel,
                    ),
                    const CourseDetailMapScreen(),
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

class _PersonLabel extends StatelessWidget {
  final int curNum;
  final int maxNum;

  const _PersonLabel({
    required this.curNum,
    required this.maxNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5).withOpacity(0.9),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Text(
        '$curNum/$maxNum',
        style: const TextStyle(
          fontSize: 13.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
