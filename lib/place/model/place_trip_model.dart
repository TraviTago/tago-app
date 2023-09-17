import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'place_trip_model.g.dart';

@JsonSerializable()
class PlaceTripModel extends PlaceModel {
  final double mapX;
  final double mapY;

  PlaceTripModel(
      {required this.mapX,
      required this.mapY,
      required super.id,
      required super.imageUrl,
      required super.overview,
      required super.title,
      super.address});

  factory PlaceTripModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceTripModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaceTripModelToJson(this);
}
