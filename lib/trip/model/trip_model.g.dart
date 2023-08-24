// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
      tripId: json['tripId'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      places:
          (json['places'] as List<dynamic>).map((e) => e as String).toList(),
      maxMember: json['maxMember'] as int,
      currentMember: json['currentMember'] as int,
      totalTime: json['totalTime'] as int,
    );

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
      'tripId': instance.tripId,
      'dateTime': instance.dateTime.toIso8601String(),
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'places': instance.places,
      'maxMember': instance.maxMember,
      'currentMember': instance.currentMember,
      'totalTime': instance.totalTime,
    };
