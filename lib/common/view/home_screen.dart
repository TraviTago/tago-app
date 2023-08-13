import 'package:flutter/material.dart';
import 'package:tago_app/course/view/list/course_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
    return Container(
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
                  const CourseListScreen(),
                  Center(child: Container(child: const Text('둘러보기'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
