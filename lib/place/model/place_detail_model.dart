import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'place_detail_model.g.dart';

@JsonSerializable()
class PlaceDetailModel extends PlaceModel {
  final String address;
  final String? homepage;
  final String? telephone;
  final String? restDate;
  final String? openTime;
  final String? parking;
  PlaceDetailModel({
    required super.id,
    required super.typeId,
    required super.title,
    required super.imgUrl,
    required super.mapx,
    required super.mapy,
    required super.overview,
    required this.address,
    this.homepage,
    this.telephone,
    this.restDate,
    this.openTime,
    this.parking,
  });

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaceDetailModelToJson(this);
}
