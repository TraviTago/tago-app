// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseParams _$CourseParamsFromJson(Map<String, dynamic> json) => CourseParams(
      placeId: json['placeId'] as int,
      tripTags:
          (json['tripTags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CourseParamsToJson(CourseParams instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'tripTags': instance.tripTags,
    };
