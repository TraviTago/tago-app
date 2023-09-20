// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_create_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripCreateParams _$TripCreateParamsFromJson(Map<String, dynamic> json) =>
    TripCreateParams(
      name: json['name'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      currentCnt: json['currentCnt'] as int,
      maxCnt: json['maxCnt'] as int,
      sameGender: json['sameGender'] as bool,
      isPet: json['isPet'] as bool,
      meetPlace: json['meetPlace'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripCreateParamsToJson(TripCreateParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dateTime': instance.dateTime.toIso8601String(),
      'currentCnt': instance.currentCnt,
      'maxCnt': instance.maxCnt,
      'sameGender': instance.sameGender,
      'isPet': instance.isPet,
      'meetPlace': instance.meetPlace,
      'types': instance.types,
      'places': instance.places,
    };
