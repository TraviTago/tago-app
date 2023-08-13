import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final int id;
  final int typeId;
  final String title;
  final String overview;
  final String imgUrl;
  final double mapx;
  final double mapy;

  PlaceModel({
    required this.id,
    required this.typeId,
    required this.title,
    required this.overview,
    required this.imgUrl,
    required this.mapx,
    required this.mapy,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
