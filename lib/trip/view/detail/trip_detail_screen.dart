import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';
import 'package:tago_app/trip/view/detail/trip_detail_map_screen.dart';
import 'package:tago_app/trip/view/detail/trip_detail_overview_screen.dart';

class TripDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'tripDetail';

  const TripDetailScreen({super.key});

  @override
  ConsumerState<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends ConsumerState<TripDetailScreen>
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
    return FutureBuilder<TripDetailModel>(
      future: ref.watch(tripRepositoryProvider).getDetailTrip(
            tripId:
                int.parse(GoRouterState.of(context).pathParameters['tripId']!),
          ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        final detailModel = snapshot.data!;

        return DefaultLayout(
          titleComponet: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  detailModel.tripName,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                _PersonLabel(
                  curNum: detailModel.currentCnt,
                  maxNum: detailModel.maxCnt,
                ),
              ],
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Material(
                  color: Colors.white,
                  elevation: 0,
                  child: Container(
                    height: 35,
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
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                          width: 3.0,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      tabs: const <Widget>[
                        Tab(
                          child: Text('코스보기'),
                        ),
                        Tab(
                          child: Text('지도로보기'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TripDetailOverViewScreen(
                        detailModel: detailModel,
                      ),
                      TripDetailMapScreen(
                        detailModel: detailModel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ... (다른 위젯 정의들은 그대로 유지) ...

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
        color: LABEL_BG_COLOR.withOpacity(0.9),
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
