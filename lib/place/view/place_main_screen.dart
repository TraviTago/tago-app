import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/place/component/place_list_card.dart';
import 'package:tago_app/place/component/place_popular_shimmer_card.dart';
import 'package:tago_app/place/component/place_recommend_card.dart';
import 'package:tago_app/place/component/place_recommend_shimmer_card.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/repository/place_repository.dart';

class PlaceMainScreen extends ConsumerStatefulWidget {
  final Function(String)? onImageChange;
  const PlaceMainScreen({super.key, this.onImageChange});

  @override
  ConsumerState<PlaceMainScreen> createState() => _PlaceMainScreenState();
}

class _PlaceMainScreenState extends ConsumerState<PlaceMainScreen> {
  final currentPageNotifier = ValueNotifier<double>(0);
  late PageController pageController;

  PlaceListModel? recommendedPlaces;
  List<PlaceModel>? popularPlaces;

  bool isPopularLoading = true;
  bool isRecommendLoading = true;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    pageController.addListener(() {
      currentPageNotifier.value = pageController.page ?? 0;
    });
    _fetchRecommendPlaces();
    _fetchPopularPlaces();
  }

  _fetchRecommendPlaces() async {
    try {
      recommendedPlaces =
          await ref.read(placeRepositoryProvider).getRecommendPlaces();
    } catch (error) {
      // 에러 처리를 원하는대로 할 수 있습니다.
    }
    setState(() {
      isRecommendLoading = false;
    });
  }

  _fetchPopularPlaces() async {
    try {
      popularPlaces =
          await ref.read(placeRepositoryProvider).getPopularPlaces();
    } catch (error) {}
    setState(() {
      isPopularLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 20.0),
                child: Row(
                  children: [
                    Text(
                      '당신을 기다리고 있는 여행지',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (isRecommendLoading) const PlaceRecommendShimmerCard(),
              if (!isRecommendLoading)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Swiper(
                    loop: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0, bottom: 30.0, left: 5.0, // 좌측 패딩 추가
                          right: 5.0,
                        ),
                        child: PlaecRecommendCard.fromModel(
                            model: recommendedPlaces!.places[index]),
                      );
                    },
                    onIndexChanged: (int index) {
                      if (widget.onImageChange != null) {
                        widget.onImageChange!(
                            recommendedPlaces!.places[index].imageUrl);
                      }
                    },
                    indicatorLayout: PageIndicatorLayout.SCALE,
                    pagination: const SwiperPagination(
                      margin: EdgeInsets.only(top: 60),
                      builder: DotSwiperPaginationBuilder(
                        size: 8,
                        activeColor: PRIMARY_COLOR,
                        color: SELECTED_BOX_BG_COLOR,
                      ),
                    ),
                    itemCount: recommendedPlaces!.places.length,
                    viewportFraction: (MediaQuery.of(context).size.width - 60) /
                        MediaQuery.of(context).size.width,
                    scale: 1,
                  ),
                ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '여행지 둘러보기',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.push('/places');
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '전체보기',
                                    style: TextStyle(
                                      color: PRIMARY_COLOR,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: PRIMARY_COLOR,
                                    size: 24.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          '요즘은 이런 곳이 인기있어요',
                          style: TextStyle(
                            color: LABEL_TEXT_COLOR,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 5 * 2 + 40,
                    child: Swiper(
                      indicatorLayout: PageIndicatorLayout.SLIDE,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            for (int i = 0; i < 2; i++)
                              Expanded(
                                child: !isPopularLoading
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: index * 2 + i <
                                                popularPlaces!.length
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 30),
                                                child: PlaceListCard.fromModel(
                                                    model: popularPlaces![
                                                        index * 2 + i]),
                                              )
                                            : Container(), // if there's no item left, add an empty container
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: index * 2 + i < 2
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.0, bottom: 30),
                                                child:
                                                    PlacePopularShimmerCard(),
                                              )
                                            : Container(), // if there's no item left, add an empty container
                                      ),
                              ),
                          ],
                        );
                      },
                      loop: false,
                      pagination: const SwiperPagination(
                        margin: EdgeInsets.only(
                          top: 60,
                        ),
                        builder: DotSwiperPaginationBuilder(
                          size: 7,
                          activeSize: 7,
                          activeColor: PRIMARY_COLOR,
                          color: SELECTED_BOX_BG_COLOR,
                        ),
                      ),
                      itemCount: !isPopularLoading
                          ? (popularPlaces!.length / 2).ceil()
                          : 1,
                      viewportFraction: 0.9,
                      scale: 1,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ));
  }
}
