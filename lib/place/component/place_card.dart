import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/utils/data_utils.dart';
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
        context.push("/placeDetail/${place.id}");
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                place.imgUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              DataUtils.cleanOverview(place
                  .overview), // Assuming overview property exists in PlaceModel
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis, // 이 부분을 추가합니다.
              maxLines: 3, // 원하는 라인 수를 설정합니다. 필요에 따라 조절 가능합니다.
            ),
          ],
        ),
      ),
    );
  }
}
