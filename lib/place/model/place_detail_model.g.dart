// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailModel _$PlaceDetailModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailModel(
      id: json['id'] as int,
      typeId: json['typeId'] as int,
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String,
      mapx: (json['mapx'] as num).toDouble(),
      mapy: (json['mapy'] as num).toDouble(),
      overview: json['overview'] as String,
      address: json['address'] as String,
      homepage: json['homepage'] as String?,
      telephone: json['telephone'] as String?,
      restDate: json['restDate'] as String?,
      openTime: json['openTime'] as String?,
      parking: json['parking'] as String?,
    );

Map<String, dynamic> _$PlaceDetailModelToJson(PlaceDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'title': instance.title,
      'overview': instance.overview,
      'imgUrl': instance.imgUrl,
      'mapx': instance.mapx,
      'mapy': instance.mapy,
      'address': instance.address,
      'homepage': instance.homepage,
      'telephone': instance.telephone,
      'restDate': instance.restDate,
      'openTime': instance.openTime,
      'parking': instance.parking,
    };
