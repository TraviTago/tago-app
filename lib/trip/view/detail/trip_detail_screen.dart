import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';
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
    int tripId = int.parse(GoRouterState.of(context).pathParameters['tripId']!);
    DateTime tripDate =
        DateTime.parse(GoRouterState.of(context).queryParameters['tripDate']!);
    int tripTime =
        int.parse(GoRouterState.of(context).queryParameters['tripTime']!);

    TripStatus tripStatus = DataUtils.getTripStatus(tripDate, tripTime);

    return FutureBuilder<TripDetailModel>(
      future: ref.watch(tripRepositoryProvider).getDetailTrip(tripId: tripId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DefaultLayout(
            child: Center(
              child: CircularProgressIndicator(color: PRIMARY_COLOR),
            ),
          );
        }

        final detailModel = snapshot.data as TripDetailModel;

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
                if (tripStatus != TripStatus.completed)
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
                          tripId: tripId,
                          tripStatus: tripStatus),
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
