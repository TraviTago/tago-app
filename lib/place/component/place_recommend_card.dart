import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/component/imageShimmer/place_recccomend_image_shimmer.dart';
import 'package:tago_app/place/model/place_model.dart';

class PlaecRecommendCard extends StatelessWidget {
  final int id;
  final String address;
  final String title;
  final String imageUrl;
  final String overview;

  const PlaecRecommendCard({
    required this.id,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.overview,
    Key? key,
  }) : super(key: key);
  factory PlaecRecommendCard.fromModel({
    required PlaceModel model,
  }) {
    return PlaecRecommendCard(
      id: model.id,
      address: model.address!,
      title: model.title,
      imageUrl: model.imageUrl,
      overview: model.overview,
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 60;
    return GestureDetector(
      onTap: () {
        context.push("/placeDetail/$id?title=$title&imgUrl=$imageUrl");
      },
      child: Material(
        // Material 위젯 추가
        elevation: 8.0, // 그림자 깊이 설정
        borderRadius: BorderRadius.circular(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                placeholder: (context, url) =>
                    const PlaceRecommendImageShimmer(), // 로딩 미리보기
                imageUrl: imageUrl,
                width: screenWidth,
                height: screenWidth,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenWidth,
                  height: (screenWidth) / 5 * 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: LABEL_TEXT_SUB_COLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            DataUtils.cleanOverview(overview, false),
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
