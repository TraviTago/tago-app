import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_trip_model.dart';

part 'trip_detail_model.g.dart';

abstract class TripDetailBaseModel {}

class TripDetailErrorModel extends TripDetailBaseModel {}

@JsonSerializable()
class TripDetailModel extends TripDetailBaseModel {
  final String tripName;
  final int currentCnt;
  final int maxCnt;
  final List<PlaceTripModel> places;
  final bool isJoined;
  final bool isDispatched;

  TripDetailModel({
    required this.tripName,
    required this.currentCnt,
    required this.maxCnt,
    required this.places,
    required this.isJoined,
    required this.isDispatched,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailModelToJson(this);
}

class TripDetailModelWithType {
  TripDetailBaseModel tripDetail;
  String type;

  TripDetailModelWithType({
    required this.tripDetail,
    required this.type,
  });
}
