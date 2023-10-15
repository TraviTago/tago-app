import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/model/trip_origin_model.dart';

part 'trip_detail_origin_model.g.dart';

@JsonSerializable()
class TripDetailOriginModel extends TripBaseModel {
  final List<TagoTrips> tagotrips;
  final String overview;

  TripDetailOriginModel({
    required this.tagotrips,
    required this.overview,
  });
  factory TripDetailOriginModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailOriginModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailOriginModelToJson(this);
}
