import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/user/model/tokens_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  Tokens tokens;

  LoginResponse({
    required this.tokens,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
