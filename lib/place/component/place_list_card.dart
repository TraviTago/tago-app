import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/place/component/place_popular_shimmer_card.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaceListCard extends StatelessWidget {
  final int id;
  final String address;
  final String title;
  final String imageUrl;
  final String overview;

  const PlaceListCard({
    required this.id,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.overview,
    Key? key,
  }) : super(key: key);

  factory PlaceListCard.fromModel({
    required PlaceModel model,
  }) {
    return PlaceListCard(
      id: model.id,
      address: model.address!,
      title: model.title,
      imageUrl: model.imageUrl,
      overview: model.overview,
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 5 * 2;
    return GestureDetector(
      onTap: () {
        context.push("/placeDetail/$id?title=$title&imgUrl=$imageUrl");
      },
      child: Material(
        // Material 위젯 추가
        elevation: 10, // 그림자 깊이 설정
        borderRadius: BorderRadius.circular(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                placeholder: (context, url) => const PlacePopularShimmerCard(),
                imageUrl: imageUrl,
                width: screenWidth,
                height: screenWidth,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenWidth,
                  height: (screenWidth) / 3 * 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: LABEL_TEXT_SUB_COLOR,
                          ),
                          maxLines: 1,
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
