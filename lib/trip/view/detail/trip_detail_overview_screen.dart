import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/detail/trip_member_card.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/place/component/place_card.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';

class TripDetailOverViewScreen extends StatelessWidget {
  final TripDetailModel detailModel;
  final TripStatusModel statusModel;

  const TripDetailOverViewScreen(
      {super.key, required this.detailModel, required this.statusModel});
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      floatingActionButton: MaterialButton(
        onPressed: () {},
        color: PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            '참여하기',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView.builder(
            itemCount: detailModel.places.length + 1, // 1을 추가
            itemBuilder: (context, index) {
              if (index < detailModel.places.length) {
                final place = detailModel.places[index];
                return PlaceCard(place: place, index: index);
              } else {
                return Column(
                  children: [
                    TripMemberCard(statusModel: statusModel),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
