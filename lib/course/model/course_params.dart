import 'package:json_annotation/json_annotation.dart';

part 'course_params.g.dart';

@JsonSerializable()
class CourseParams {
  final int placeId;
  final List<String> tripTags;

  const CourseParams({
    required this.placeId,
    required this.tripTags,
  });

  factory CourseParams.fromJson(Map<String, dynamic> json) =>
      _$CourseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CourseParamsToJson(this);
}
