import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/model/place_trip_model.dart';
import 'package:tago_app/trip/model/trip_edit_model.dart';

class TripCompleteCard extends StatelessWidget {
  final DateTime dateTime;
  final String name;
  final String imageUrl;
  final List<PlaceTripModel> places;
  final int totalTime;

  const TripCompleteCard({
    required this.dateTime,
    required this.name,
    required this.imageUrl,
    required this.places,
    required this.totalTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 60;
    TripEditModel editModel = TripEditModel(places: places, name: name);
    return GestureDetector(
      onTap: () {
        context.push(
          '/tripEdit',
          extra: editModel,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: <Widget>[
            Image.network(
              imageUrl,
              width: screenWidth,
              height: screenWidth,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: (screenWidth) / 3,
                decoration: BoxDecoration(
                  color: TRIP_CARD_BLUR_COLOR.withOpacity(0.8),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DateAndName(
                            date: dateTime,
                            name: name,
                            duration: totalTime,
                          ),
                        ],
                      ),
                      Text(
                        places.map((place) => place.title).join(' · '),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
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
    );
  }
}

class _DateAndName extends StatelessWidget {
  final String name;
  final DateTime date;
  final int duration;

  const _DateAndName({
    required this.name,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${DataUtils.formatDate(date)} - $name',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '소요시간 ${DataUtils.formatDuration(duration)}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
