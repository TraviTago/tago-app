import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'trip_detail_model.g.dart';

@JsonSerializable()
class TripDetailModel {
  final String tripName;
  final int currentCnt;
  final int maxCnt;
  final List<PlaceModel> places;

  TripDetailModel({
    required this.tripName,
    required this.currentCnt,
    required this.maxCnt,
    required this.places,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailModelToJson(this);
}
