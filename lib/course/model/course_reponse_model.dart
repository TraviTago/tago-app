import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_trip_model.dart';

part 'course_reponse_model.g.dart';

@JsonSerializable()
class CourseResponseModel {
  final String imgUrl;
  final int totalTime;
  final List<PlaceTripModel> places;

  CourseResponseModel({
    required this.imgUrl,
    required this.totalTime,
    required this.places,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseResponseModelToJson(this);
}
