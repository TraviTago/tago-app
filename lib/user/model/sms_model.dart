import 'package:json_annotation/json_annotation.dart';

part 'sms_model.g.dart';

@JsonSerializable()
class SmsVerifyResponse {
  final bool isVerify;
  final bool isSignUp;

  SmsVerifyResponse({
    required this.isVerify,
    required this.isSignUp,
  });

  factory SmsVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsVerifyResponseFromJson(json);
}
