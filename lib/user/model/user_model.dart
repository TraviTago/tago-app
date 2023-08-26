import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/signup/model/sign_up_model.dart';

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
  final String oauthProvider;
  final String email;
  final String? imgUrl;
  final String? name;
  final SignUpModel? profile;

  UserModel({
    required this.oauthProvider,
    required this.email,
    required this.imgUrl,
    required this.name,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
