import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/course/component/detail/course_member_card.dart';
import 'package:tago_app/course/model/course_detail_model.dart';
import 'package:tago_app/place/component/place_card.dart';

class CourseDetailOverViewScreen extends StatelessWidget {
  final CourseDetailModel detailModel;

  const CourseDetailOverViewScreen({super.key, required this.detailModel});
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
                return CourseMemberCard(detailModel: detailModel);
              }
            },
          ),
        ),
      ),
    );
  }
}
