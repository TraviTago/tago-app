// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      sns: json['sns'] as String,
      email: json['email'] as String,
      nickName: json['nickName'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'sns': instance.sns,
      'email': instance.email,
      'nickName': instance.nickName,
    };
