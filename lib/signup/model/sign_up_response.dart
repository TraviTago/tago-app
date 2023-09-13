import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/user/model/tokens_model.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  final int memberId;
  final String authority;
  final Tokens tokens;

  SignUpResponse({
    required this.memberId,
    required this.authority,
    required this.tokens,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}
