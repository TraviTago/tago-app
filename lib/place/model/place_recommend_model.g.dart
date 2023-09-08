// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_recommend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceRecommendModel _$PlaceRecommendModelFromJson(Map<String, dynamic> json) =>
    PlaceRecommendModel(
      id: json['id'] as int,
      title: json['title'] as String,
      address: json['address'] as String,
      overview: json['overview'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PlaceRecommendModelToJson(
        PlaceRecommendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'overview': instance.overview,
    };
