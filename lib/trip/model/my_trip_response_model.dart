import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/trip/model/trip_model.dart';

part 'my_trip_response_model.g.dart';

@JsonSerializable()
class MyTripResponseModel {
  final List<TripModel> trips;

  MyTripResponseModel({required this.trips});

  factory MyTripResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyTripResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyTripResponseModelToJson(this);
}
