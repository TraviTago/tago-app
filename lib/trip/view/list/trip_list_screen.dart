import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/component/trip_card.dart';
import 'package:tago_app/trip/component/trip_list_skeleton.dart';
import 'package:tago_app/trip/component/trip_recommend_card.dart';
import 'package:tago_app/trip/component/trip_recommend_shimmer_card.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/provider/trip_provider.dart';
import 'package:tago_app/trip/provider/trip_recommend_provider.dart';

class TripListScreen extends ConsumerStatefulWidget {
  const TripListScreen({super.key});

  @override
  ConsumerState<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends ConsumerState<TripListScreen> {
  final ScrollController controller = ScrollController();
  late ValueNotifier<TripModel?> tripRecommendDataNotifier =
      ValueNotifier<TripModel?>(null);

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);

    ref.read(recommendProvider.notifier).fetchRecommendTrip();
  }

  @override
  void dispose() {
    tripRecommendDataNotifier.dispose();
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
    final tripRecommendData = ref.watch(recommendProvider);

    if (contents is CursorPaginationLoading) {
      return const TripListSkeleton();
    }

    final cp = contents as CursorPagination;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton.extended(
            shape: const CircleBorder(),
            label: const Icon(
              Icons.add,
              size: 45,
            ),
            onPressed: () {
              context.go('/tripForm1');
            },
            backgroundColor: PRIMARY_COLOR,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.grey,
        onRefresh: () async {
          await ref.read(tripProvider.notifier).paginate(forceRefetch: true);
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == cp.contents.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Center(
                          child: contents is CursorPaginationFetchingMore
                              ? const CircularProgressIndicator()
                              : Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: LABEL_BG_COLOR,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_upward,
                                      color: LABEL_TEXT_SUB_COLOR,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      controller.animateTo(
                                        0.0, // 맨 위로 이동
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.bounceIn,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      );
                    }

                    DateTime? previousDate;
                    if (index - 1 >= 0) {
                      previousDate = cp.contents[index - 1].dateTime;
                    }

                    final bool shouldShowDate = previousDate == null ||
                        !DataUtils.isSameDate(
                            previousDate, cp.contents[index].dateTime);

                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '당신에게 딱 맞는 여행!',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          tripRecommendData == null
                              ? const TripRecommendShimmerCard()
                              : (tripRecommendData is TripModel)
                                  ? TripRecommendCard.fromModel(
                                      model: tripRecommendData)
                                  : Container(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            DataUtils.formatDate(cp.contents[index].dateTime),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TripCard.fromModel(
                            model: cp.contents[index],
                          ),
                        ],
                      );
                    }
                    if (shouldShowDate) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DataUtils.formatDate(cp.contents[index].dateTime),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TripCard.fromModel(model: cp.contents[index]),
                        ],
                      );
                    } else {
                      return TripCard.fromModel(model: cp.contents[index]);
                    }
                  },
                  childCount: cp.contents.length + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
