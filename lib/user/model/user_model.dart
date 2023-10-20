import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

//유저 로딩 실패
class UserModelError extends UserModelBase {}

//유저 로딩
class UserModelLoading extends UserModelBase {}

//유저 로딩 성공
@JsonSerializable()
class UserModel extends UserModelBase {
  final String number;
  final String imgUrl;
  final String name;
  final int ageRange;
  final String gender;
  final String mbti;
  List<String> favorites;
  List<String> tripTypes;
  bool? isTutorial;

  UserModel({
    required this.number,
    required this.imgUrl,
    required this.name,
    required this.ageRange,
    required this.gender,
    required this.mbti,
    required this.favorites,
    required this.tripTypes,
    this.isTutorial,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
