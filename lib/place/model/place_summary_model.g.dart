// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceSummaryModel _$PlaceSummaryModelFromJson(Map<String, dynamic> json) =>
    PlaceSummaryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      address: json['address'] as String,
      overview: json['overview'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PlaceSummaryModelToJson(PlaceSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'overview': instance.overview,
    };
