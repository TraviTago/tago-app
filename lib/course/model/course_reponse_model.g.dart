// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_reponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResponseModel _$CourseResponseModelFromJson(Map<String, dynamic> json) =>
    CourseResponseModel(
      imgUrl: json['imgUrl'] as String,
      totalTime: json['totalTime'] as int,
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseResponseModelToJson(
        CourseResponseModel instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'totalTime': instance.totalTime,
      'places': instance.places,
    };
