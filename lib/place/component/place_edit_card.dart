import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/place/model/place_model.dart';

class PlaceEditCard extends StatelessWidget {
  final PlaceModel place;
  final int index;
  final VoidCallback onRemove;

  const PlaceEditCard({
    required this.place,
    required this.index,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: LABEL_BG_COLOR,
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: OutlinedButton(
                            onPressed: onRemove,
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return PRIMARY_COLOR;
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.white;
                                },
                              ),
                              side: MaterialStateProperty.all(
                                BorderSide.none, // border 제거
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          place.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                ReorderableDragStartListener(
                  index: index, // 여기서 'index'는 ListView.builder의 index입니다.
                  child: const Icon(
                    Icons.menu,
                    size: 25,
                    color: LABEL_TEXT_COLOR,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: place.imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
