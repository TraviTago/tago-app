// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      imageUrl: json['imageUrl'] as String,
      mapX: (json['mapX'] as num).toDouble(),
      mapY: (json['mapY'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'imageUrl': instance.imageUrl,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
    };
