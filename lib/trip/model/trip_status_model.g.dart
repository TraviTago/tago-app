// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripStatusModel _$TripStatusModelFromJson(Map<String, dynamic> json) =>
    TripStatusModel(
      femaleCnt: json['femaleCnt'] as int,
      meatPlace: json['meatPlace'] as String,
      maleCnt: json['maleCnt'] as int,
      ageGroup:
          (json['ageGroup'] as List<dynamic>).map((e) => e as int).toList(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$TripStatusModelToJson(TripStatusModel instance) =>
    <String, dynamic>{
      'femaleCnt': instance.femaleCnt,
      'maleCnt': instance.maleCnt,
      'meatPlace': instance.meatPlace,
      'ageGroup': instance.ageGroup,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
