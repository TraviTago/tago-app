import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_trip_model.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';

part 'trip_detail_driver_model.g.dart';

@JsonSerializable()
class TripDetailDriverModel extends TripDetailBaseModel {
  final String tripName;
  final int currentCnt;
  final int maxCnt;
  final List<PlaceTripModel> places;
  final bool isDispatched;

  TripDetailDriverModel({
    required this.tripName,
    required this.currentCnt,
    required this.maxCnt,
    required this.places,
    required this.isDispatched,
  });

  factory TripDetailDriverModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailDriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailDriverModelToJson(this);
}
