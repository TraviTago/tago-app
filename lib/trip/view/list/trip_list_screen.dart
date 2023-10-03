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
  bool isPetSelected = false;
  bool isSameGenderSelected = false;
  final ScrollController controller = ScrollController();

  void _togglePetFilter() {
    setState(() {
      isPetSelected = !isPetSelected;
    });
    ref.read(tripProvider.notifier).paginate(
          forceRefetch: true,
          isPet: isPetSelected,
          sameGender: isSameGenderSelected,
        );
  }

  void _toggleGenderFilter() {
    setState(() {
      isSameGenderSelected = !isSameGenderSelected;
    });
    ref.read(tripProvider.notifier).paginate(
          forceRefetch: true,
          isPet: isPetSelected,
          sameGender: isSameGenderSelected,
        );
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    ref.read(recommendProvider.notifier).fetchRecommendTrip();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(tripProvider.notifier).paginate(
            isPet: isPetSelected,
            sameGender: isSameGenderSelected,
            fetchMore: true,
          );
    }
  }

  Widget _buildListContent(CursorPagination cp, bool showRecommendation) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      itemBuilder: (context, index) {
        if (showRecommendation && index == 0) {
          final tripRecommendData = ref.watch(recommendProvider);
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
              const SizedBox(height: 10.0),
              tripRecommendData == null
                  ? const TripRecommendShimmerCard()
                  : (tripRecommendData is TripModel)
                      ? TripRecommendCard.fromModel(model: tripRecommendData)
                      : Container(),
              const SizedBox(height: 20.0),
            ],
          );
        }

        int tripIndex = showRecommendation ? index - 1 : index;
        DateTime? previousDate;
        if (tripIndex > 0) {
          previousDate = cp.contents[tripIndex - 1].dateTime;
        }

        final bool shouldShowDate = previousDate == null ||
            !DataUtils.isSameDate(
                previousDate, cp.contents[tripIndex].dateTime);

        if (shouldShowDate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DataUtils.formatDate(cp.contents[tripIndex].dateTime),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20.0),
              TripCard.fromModel(model: cp.contents[tripIndex]),
            ],
          );
        } else {
          return TripCard.fromModel(model: cp.contents[tripIndex]);
        }
      },
      itemCount:
          showRecommendation ? cp.contents.length + 1 : cp.contents.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final contents = ref.watch(tripProvider);
    bool showRecommendation = !(isPetSelected || isSameGenderSelected);

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
          await ref.read(tripProvider.notifier).paginate(
                forceRefetch: true,
                isPet: isPetSelected,
                sameGender: isSameGenderSelected,
              );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 15.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _toggleGenderFilter,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isSameGenderSelected
                            ? PRIMARY_COLOR
                            : LABEL_BG_COLOR,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        isSameGenderSelected ? "동성만" : '성별',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: isSameGenderSelected
                              ? Colors.white
                              : Colors.black,
                          fontWeight: isSameGenderSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  GestureDetector(
                    onTap: _togglePetFilter,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isPetSelected ? PRIMARY_COLOR : LABEL_BG_COLOR,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        isPetSelected ? "좋아요!" : '반려동물',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: isPetSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isPetSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: contents is CursorPaginationLoading
                  ? (isPetSelected || isSameGenderSelected)
                      ? const TripListSkeleton(
                          isRecommend: false,
                        )
                      : const TripListSkeleton(
                          isRecommend: true,
                        )
                  : _buildListContent(
                      contents as CursorPagination, showRecommendation),
            ),
          ],
        ),
      ),
    );
  }
}
