// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_trip_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTripResponseModel _$MyTripResponseModelFromJson(Map<String, dynamic> json) =>
    MyTripResponseModel(
      trips: (json['trips'] as List<dynamic>)
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyTripResponseModelToJson(
        MyTripResponseModel instance) =>
    <String, dynamic>{
      'trips': instance.trips,
    };
