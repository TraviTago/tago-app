// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_origin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripOriginModel _$TripOriginModelFromJson(Map<String, dynamic> json) =>
    TripOriginModel(
      tagotrips: (json['tagotrips'] as List<dynamic>)
          .map((e) => TagoTrips.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripOriginModelToJson(TripOriginModel instance) =>
    <String, dynamic>{
      'tagotrips': instance.tagotrips,
    };

TagoTrips _$TagoTripsFromJson(Map<String, dynamic> json) => TagoTrips(
      name: json['name'] as String,
      imgUrl: json['img_url'] as String,
    );

Map<String, dynamic> _$TagoTripsToJson(TagoTrips instance) => <String, dynamic>{
      'name': instance.name,
      'img_url': instance.imgUrl,
    };
