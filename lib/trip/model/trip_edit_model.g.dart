// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_edit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripEditModel _$TripEditModelFromJson(Map<String, dynamic> json) =>
    TripEditModel(
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$TripEditModelToJson(TripEditModel instance) =>
    <String, dynamic>{
      'places': instance.places,
      'name': instance.name,
    };
