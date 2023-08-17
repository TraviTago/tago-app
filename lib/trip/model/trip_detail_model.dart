import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'trip_detail_model.g.dart';

@JsonSerializable()
class TripDetailModel extends TripModel {
  final List<PlaceModel> places;

  TripDetailModel({
    required super.id,
    required super.name,
    required super.imgUrl,
    required super.tags,
    required super.maxNum,
    required super.curNum,
    required super.duration,
    required super.startDate,
    required this.places,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TripDetailModelToJson(this);
}
