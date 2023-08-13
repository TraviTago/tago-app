// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['id'] as int,
      typeId: json['typeId'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      imgUrl: json['imgUrl'] as String,
      mapx: (json['mapx'] as num).toDouble(),
      mapy: (json['mapy'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'title': instance.title,
      'overview': instance.overview,
      'imgUrl': instance.imgUrl,
      'mapx': instance.mapx,
      'mapy': instance.mapy,
    };
