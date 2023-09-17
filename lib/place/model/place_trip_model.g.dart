// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceTripModel _$PlaceTripModelFromJson(Map<String, dynamic> json) =>
    PlaceTripModel(
      mapX: (json['mapX'] as num).toDouble(),
      mapY: (json['mapY'] as num).toDouble(),
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      overview: json['overview'] as String,
      title: json['title'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PlaceTripModelToJson(PlaceTripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
    };
