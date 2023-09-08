import 'package:json_annotation/json_annotation.dart';

part 'place_recommend_model.g.dart';

@JsonSerializable()
class PlaceRecommendModel {
  final int id;
  final String title;
  final String address;
  final String imageUrl;
  final String overview;

  PlaceRecommendModel({
    required this.id,
    required this.title,
    required this.address,
    required this.overview,
    required this.imageUrl,
  });

  factory PlaceRecommendModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceRecommendModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceRecommendModelToJson(this);
}
