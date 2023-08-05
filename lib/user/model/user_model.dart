import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum SNSPlatform { APPLE, KAKAO }

abstract class UserModelBase {}

//유저 로딩 실패
class UserModelError extends UserModelBase {}

//유저 로딩
class UserModelLoading extends UserModelBase {}

//유저 로딩 성공
@JsonSerializable()
class UserModel extends UserModelBase {
  final String sns;
  final String email;
  final String? nickName;

  UserModel({
    required this.sns,
    required this.email,
    required this.nickName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
