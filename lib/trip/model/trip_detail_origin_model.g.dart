// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_origin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailOriginModel _$TripDetailOriginModelFromJson(
        Map<String, dynamic> json) =>
    TripDetailOriginModel(
      tagotrips: (json['tagotrips'] as List<dynamic>)
          .map((e) => TagoTrips.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: json['source'] as String,
    );

Map<String, dynamic> _$TripDetailOriginModelToJson(
        TripDetailOriginModel instance) =>
    <String, dynamic>{
      'tagotrips': instance.tagotrips,
      'source': instance.source,
    };
