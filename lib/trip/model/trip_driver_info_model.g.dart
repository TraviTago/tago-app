// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_driver_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDriverInfoModel _$TripDriverInfoModelFromJson(Map<String, dynamic> json) =>
    TripDriverInfoModel(
      img_url: json['img_url'] as String,
      name: json['name'] as String,
      comment: json['comment'] as String,
      phone_number: json['phone_number'] as String,
      car_number: json['car_number'] as String,
      licence: json['licence'] as String,
      seater: json['seater'] as int,
    );

Map<String, dynamic> _$TripDriverInfoModelToJson(
        TripDriverInfoModel instance) =>
    <String, dynamic>{
      'img_url': instance.img_url,
      'name': instance.name,
      'comment': instance.comment,
      'phone_number': instance.phone_number,
      'licence': instance.licence,
      'seater': instance.seater,
      'car_number': instance.car_number,
    };
