import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/place/component/place_recommend_card.dart';
import 'package:tago_app/place/model/place_summary_model.dart';

class PlaceMainScreen extends StatefulWidget {
  final Function(String)? onImageChange;
  const PlaceMainScreen({super.key, this.onImageChange});

  @override
  State<PlaceMainScreen> createState() => _PlaceMainScreenState();
}

class _PlaceMainScreenState extends State<PlaceMainScreen> {
  final currentPageNotifier = ValueNotifier<double>(0);
  late PageController pageController;
  List<PlaceSummaryModel> places = placeList;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    pageController.addListener(() {
      currentPageNotifier.value =
          pageController.page ?? 0; // 리스너에서는 currentPageNotifier만 업데이트합니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                      child: PlaecRecommendCard.fromModel(model: places[index]),
                    );
                  },
                  onIndexChanged: (int index) {
                    if (widget.onImageChange != null) {
                      widget.onImageChange!(places[index].imageUrl);
                    }
                  },
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.only(top: 60),
                    builder: DotSwiperPaginationBuilder(
                      size: 7,
                      activeSize: 7,
                      activeColor: PRIMARY_COLOR,
                      color: SELECTED_BOX_BG_COLOR,
                    ),
                  ),
                  itemCount: 3,
                  viewportFraction: 0.8,
                  scale: 0.8,
                ),
              ),
            ],
          ),
        ));
  }
}
