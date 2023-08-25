import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final int id;
  final String title;
  final String overview;
  final String imageUrl;
  final double mapX;
  final double mapY;

  PlaceModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.mapX,
    required this.mapY,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
