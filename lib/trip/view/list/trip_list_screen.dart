import 'package:card_swiper/card_swiper.dart';
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
import 'package:tago_app/trip/model/trip_origin_model.dart';
import 'package:tago_app/trip/provider/trip_origin_provider.dart';
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
    ref.read(originProvider.notifier).fetchOriginTrips();
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
            label: const Icon(Icons.add, size: 45),
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
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: false,
              backgroundColor: Colors.white,
              elevation: 5.0,
              flexibleSpace: FilterBar(
                isSameGenderSelected: isSameGenderSelected,
                isPetSelected: isPetSelected,
                onToggleGenderFilter: _toggleGenderFilter,
                onTogglePetFilter: _togglePetFilter,
              ),
              expandedHeight: 20.0,
            ),
            if (contents is CursorPaginationLoading &&
                (isPetSelected || isSameGenderSelected))
              const SliverFillRemaining(
                  child: TripListSkeleton(
                isRecommend: false,
              )),
            if (contents is CursorPaginationLoading &&
                (!isPetSelected && !isSameGenderSelected))
              const SliverFillRemaining(
                  child: TripListSkeleton(
                isRecommend: true,
              )),
            if (contents is! CursorPaginationLoading)
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (showRecommendation && index == 0) {
                        final tripRecommendData = ref.watch(recommendProvider);
                        final tripOriginData = ref.watch(originProvider);
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  '타고가 제안하는\n지금 떠나기 좋은 여행',
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              tripOriginData == null
                                  ? Container(
                                      child: const Text("NO DATA"),
                                    )
                                  : (tripOriginData is TripOriginModel)
                                      ? SizedBox(
                                          height:
                                              MediaQuery.of(context).size.width,
                                          child: Swiper(
                                            autoplay: true,
                                            loop: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Stack(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // context.go(
                                                        //     '/tripDetailOrigin/${tripOriginData.tagotrips[index].name}');
                                                      },
                                                      child: ClipRRect(
                                                        child: Image.network(
                                                          tripOriginData
                                                              .tagotrips[index]
                                                              .imgUrl,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 20,
                                                    bottom: 50,
                                                    child: Text(
                                                      tripOriginData
                                                          .tagotrips[index]
                                                          .name,
                                                      style: const TextStyle(
                                                        shadows: [
                                                          Shadow(
                                                            blurRadius: 5.0,
                                                            color:
                                                                Colors.black45,
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            indicatorLayout:
                                                PageIndicatorLayout.SCALE,
                                            pagination: SwiperPagination(
                                              builder:
                                                  DotSwiperPaginationBuilder(
                                                size: 10,
                                                activeColor: Colors.white
                                                    .withOpacity(0.9),
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            itemCount: 3,
                                            scale: 1,
                                          ),
                                        )
                                      : Container(
                                          child: const Text("NO DATA"),
                                        ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  '당신에게 딱 맞는 여행!',
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              tripRecommendData == null
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TripRecommendShimmerCard(),
                                    )
                                  : (tripRecommendData is TripModel)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TripRecommendCard.fromModel(
                                              type: "USER",
                                              model: tripRecommendData),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TripRecommendShimmerCard(),
                                        ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        );
                      }

                      int tripIndex = showRecommendation ? index - 1 : index;
                      DateTime? previousDate;
                      if (tripIndex > 0) {
                        previousDate =
                            (contents).contents[tripIndex - 1].dateTime;
                      }

                      final bool shouldShowDate = previousDate == null ||
                          !DataUtils.isSameDate(previousDate,
                              (contents).contents[tripIndex].dateTime);

                      if (shouldShowDate) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
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
                                  type: "USER",
                                  model: (contents).contents[tripIndex]),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TripCard.fromModel(
                              type: "USER",
                              model: (contents).contents[tripIndex]),
                        );
                      }
                    },
                    childCount: showRecommendation
                        ? (contents as CursorPagination).contents.length + 1
                        : (contents as CursorPagination).contents.length,
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

class FilterBar extends StatelessWidget {
  final bool isSameGenderSelected;
  final bool isPetSelected;
  final Function() onToggleGenderFilter;
  final Function() onTogglePetFilter;

  const FilterBar({
    super.key,
    required this.isSameGenderSelected,
    required this.isPetSelected,
    required this.onToggleGenderFilter,
    required this.onTogglePetFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 15.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggleGenderFilter,
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 30,
              decoration: BoxDecoration(
                color: isSameGenderSelected ? PRIMARY_COLOR : LABEL_BG_COLOR,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                isSameGenderSelected ? "동성만" : '성별',
                style: TextStyle(
                  fontSize: 13.0,
                  color: isSameGenderSelected ? Colors.white : Colors.black,
                  fontWeight:
                      isSameGenderSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          GestureDetector(
            onTap: onTogglePetFilter,
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 30,
              decoration: BoxDecoration(
                color: isPetSelected ? PRIMARY_COLOR : LABEL_BG_COLOR,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                isPetSelected ? "좋아요!" : '반려동물',
                style: TextStyle(
                  fontSize: 13.0,
                  color: isPetSelected ? Colors.white : Colors.black,
                  fontWeight: isPetSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
