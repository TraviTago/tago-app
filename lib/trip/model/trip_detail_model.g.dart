// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailModel _$TripDetailModelFromJson(Map<String, dynamic> json) =>
    TripDetailModel(
      tripName: json['tripName'] as String,
      currentCnt: json['currentCnt'] as int,
      maxCnt: json['maxCnt'] as int,
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isJoined: json['isJoined'] as bool,
    );

Map<String, dynamic> _$TripDetailModelToJson(TripDetailModel instance) =>
    <String, dynamic>{
      'tripName': instance.tripName,
      'currentCnt': instance.currentCnt,
      'maxCnt': instance.maxCnt,
      'places': instance.places,
      'isJoined': instance.isJoined,
    };
