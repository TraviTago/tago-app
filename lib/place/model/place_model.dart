import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final String id;
  final String title;
  final String imgUrl;
  final String mapx;
  final String mapy;

  PlaceModel({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.mapx,
    required this.mapy,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
