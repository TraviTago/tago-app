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
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
    };

PlaceListModel _$PlaceListModelFromJson(Map<String, dynamic> json) =>
    PlaceListModel(
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceListModelToJson(PlaceListModel instance) =>
    <String, dynamic>{
      'places': instance.places,
    };
