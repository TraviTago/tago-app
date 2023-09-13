import 'package:json_annotation/json_annotation.dart';

part 'sms_model.g.dart';

@JsonSerializable()
class SmsVerifyResponse {
  final bool verify;

  SmsVerifyResponse({
    required this.verify,
  });

  factory SmsVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsVerifyResponseFromJson(json);
}
