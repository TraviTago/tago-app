import 'package:json_annotation/json_annotation.dart';

part 'trip_driver_info_model.g.dart';

@JsonSerializable()
class TripDriverInfoModel {
  final String img_url;
  final String name;
  final String comment;
  final String phone_number;
  final String licence;
  final int seater;
  final String car_number;

  TripDriverInfoModel({
    required this.img_url,
    required this.name,
    required this.comment,
    required this.phone_number,
    required this.car_number,
    required this.licence,
    required this.seater,
  });

  factory TripDriverInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TripDriverInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDriverInfoModelToJson(this);
}
