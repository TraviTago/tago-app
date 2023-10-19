import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/component/imageShimmer/place_detail_image_shimmer.dart';
import 'package:tago_app/place/model/place_model.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  final int index;

  const PlaceCard({required this.place, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
            "/placeDetail/${place.id}?title=${place.title}&imgUrl=${place.imageUrl}");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DataUtils.numberToKoreanOrdinal(index + 1)}번째,',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      place.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 35,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: ObjectKey(place.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const PlaceDetailImageShimmer(),
                  imageUrl: place.imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              DataUtils.cleanOverview(place.overview, false),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis, // 이 부분을 추가합니다.
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
