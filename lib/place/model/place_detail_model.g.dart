// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailModel _$PlaceDetailModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      overview: json['overview'] as String,
      address: json['address'] as String?,
      typeId: json['typeId'] as String,
      mapX: (json['mapX'] as num).toDouble(),
      mapY: (json['mapY'] as num).toDouble(),
      homepage: json['homepage'] as String?,
      telephone: json['telephone'] as String?,
      restDate: json['restDate'] as String?,
      openTime: json['openTime'] as String?,
      parking: json['parking'] as String?,
    );

Map<String, dynamic> _$PlaceDetailModelToJson(PlaceDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'homepage': instance.homepage,
      'telephone': instance.telephone,
      'restDate': instance.restDate,
      'openTime': instance.openTime,
      'parking': instance.parking,
      'typeId': instance.typeId,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
    };
