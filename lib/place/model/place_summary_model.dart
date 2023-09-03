import 'package:json_annotation/json_annotation.dart';

part 'place_summary_model.g.dart';

@JsonSerializable()
class PlaceSummaryModel {
  final int id;
  final String title;
  final String address;
  final String imageUrl;
  final String overview;

  PlaceSummaryModel({
    required this.id,
    required this.title,
    required this.address,
    required this.overview,
    required this.imageUrl,
  });

  factory PlaceSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceSummaryModelToJson(this);
}
