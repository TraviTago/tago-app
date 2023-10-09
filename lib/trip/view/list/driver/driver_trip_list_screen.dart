import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/component/trip_card.dart';
import 'package:tago_app/trip/component/trip_list_skeleton.dart';
import 'package:tago_app/trip/provider/trip_provider.dart';

class DriverTripListScreen extends ConsumerStatefulWidget {
  const DriverTripListScreen({super.key});

  @override
  ConsumerState<DriverTripListScreen> createState() =>
      _DriverTripListScreenState();
}

class _DriverTripListScreenState extends ConsumerState<DriverTripListScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(tripProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final contents = ref.watch(tripProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Colors.grey,
        onRefresh: () async {
          await ref.read(tripProvider.notifier).paginate(
                forceRefetch: true,
              );
        },
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            if (contents is CursorPaginationLoading)
              const SliverFillRemaining(
                  child: TripListSkeleton(
                isRecommend: false,
              )),
            if (contents is! CursorPaginationLoading)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      int tripIndex = index;
                      DateTime? previousDate;
                      if (tripIndex > 0) {
                        previousDate =
                            (contents).contents[tripIndex - 1].dateTime;
                      }

                      final bool shouldShowDate = previousDate == null ||
                          !DataUtils.isSameDate(previousDate,
                              (contents).contents[tripIndex].dateTime);

                      if (shouldShowDate) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              DataUtils.formatDate(
                                  (contents).contents[tripIndex].dateTime),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TripCard.fromModel(
                                type: "DRIVER",
                                model: (contents).contents[tripIndex]),
                          ],
                        );
                      } else {
                        return TripCard.fromModel(
                            type: "DRIVER",
                            model: (contents).contents[tripIndex]);
                      }
                    },
                    childCount: (contents as CursorPagination).contents.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
