// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsVerifyResponse _$SmsVerifyResponseFromJson(Map<String, dynamic> json) =>
    SmsVerifyResponse(
      isVerify: json['isVerify'] as bool,
      isSignUp: json['isSignUp'] as bool,
    );

Map<String, dynamic> _$SmsVerifyResponseToJson(SmsVerifyResponse instance) =>
    <String, dynamic>{
      'isVerify': instance.isVerify,
      'isSignUp': instance.isSignUp,
    };
