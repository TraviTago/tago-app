import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/course/model/course_model.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'course_detail_model.g.dart';

@JsonSerializable()
class CourseDetailModel extends CourseModel {
  final List<PlaceModel> places;

  CourseDetailModel({
    required super.id,
    required super.name,
    required super.imgUrl,
    required super.tags,
    required super.maxNum,
    required super.curNum,
    required super.duration,
    required super.startDate,
    required this.places,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);
}
