import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/trip/model/trip_model.dart';

part 'trip_response_model.g.dart';

@JsonSerializable()
class MyTripResponseModel {
  final List<TripModel> trips;

  MyTripResponseModel({required this.trips});

  factory MyTripResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyTripResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyTripResponseModelToJson(this);
}

@JsonSerializable()
class TripCreateResponse {
  final int tripId;

  TripCreateResponse({
    required this.tripId,
  });

  factory TripCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$TripCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripCreateResponseToJson(this);
}
