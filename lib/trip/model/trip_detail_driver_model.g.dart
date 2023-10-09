// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailDriverModel _$TripDetailDriverModelFromJson(
        Map<String, dynamic> json) =>
    TripDetailDriverModel(
      tripName: json['tripName'] as String,
      currentCnt: json['currentCnt'] as int,
      maxCnt: json['maxCnt'] as int,
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDispatched: json['isDispatched'] as bool,
    );

Map<String, dynamic> _$TripDetailDriverModelToJson(
        TripDetailDriverModel instance) =>
    <String, dynamic>{
      'tripName': instance.tripName,
      'currentCnt': instance.currentCnt,
      'maxCnt': instance.maxCnt,
      'places': instance.places,
      'isDispatched': instance.isDispatched,
    };
