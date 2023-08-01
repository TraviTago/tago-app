// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      maxNum: json['maxNum'] as int,
      curNum: json['curNum'] as int,
      duration: json['duration'] as int,
      startDate: json['startDate'] as int,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'tags': instance.tags,
      'maxNum': instance.maxNum,
      'curNum': instance.curNum,
      'duration': instance.duration,
      'startDate': instance.startDate,
    };
