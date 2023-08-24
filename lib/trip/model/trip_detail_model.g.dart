// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailModel _$TripDetailModelFromJson(Map<String, dynamic> json) =>
    TripDetailModel(
      tripId: json['tripId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      maxMember: json['maxMember'] as int,
      currentMember: json['currentMember'] as int,
      totalTime: json['totalTime'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripDetailModelToJson(TripDetailModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'dateTime': instance.dateTime.toIso8601String(),
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'maxMember': instance.maxMember,
      'currentMember': instance.currentMember,
      'totalTime': instance.totalTime,
      'places': instance.places,
    };
