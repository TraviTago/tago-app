// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripJoinResponseModel _$TripJoinResponseModelFromJson(
        Map<String, dynamic> json) =>
    TripJoinResponseModel(
      tripId: json['tripId'] as int,
    );

Map<String, dynamic> _$TripJoinResponseModelToJson(
        TripJoinResponseModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
    };

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

TripCreateResponse _$TripCreateResponseFromJson(Map<String, dynamic> json) =>
    TripCreateResponse(
      tripId: json['tripId'] as int,
    );

Map<String, dynamic> _$TripCreateResponseToJson(TripCreateResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
    };
