// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailModel _$TripDetailModelFromJson(Map<String, dynamic> json) =>
    TripDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      maxNum: json['maxNum'] as int,
      curNum: json['curNum'] as int,
      duration: json['duration'] as int,
      startDate: json['startDate'] as int,
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripDetailModelToJson(TripDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'tags': instance.tags,
      'maxNum': instance.maxNum,
      'curNum': instance.curNum,
      'duration': instance.duration,
      'startDate': instance.startDate,
      'places': instance.places,
    };
