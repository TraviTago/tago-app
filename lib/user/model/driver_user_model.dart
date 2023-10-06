import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/user/model/user_model.dart';

part 'driver_user_model.g.dart';

@JsonSerializable()
class DriverUserModel extends UserModelBase {
  final String imgUrl;
  final String name;

  DriverUserModel({
    required this.imgUrl,
    required this.name,
  });

  factory DriverUserModel.fromJson(Map<String, dynamic> json) =>
      _$DriverUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverUserModelToJson(this);
}
