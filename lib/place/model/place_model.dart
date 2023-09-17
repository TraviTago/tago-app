import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final int id;
  final String title;
  final String overview;
  final String imageUrl;
  final String? address;

  PlaceModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    this.address,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}

@JsonSerializable()
class PlaceListModel {
  final List<PlaceModel> places;

  PlaceListModel({
    required this.places,
  });

  factory PlaceListModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceListModelToJson(this);
}
