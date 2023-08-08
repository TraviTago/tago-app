// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      oauthProvider: json['oauthProvider'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      signedUp: json['signedUp'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'oauthProvider': instance.oauthProvider,
      'email': instance.email,
      'name': instance.name,
      'signedUp': instance.signedUp,
    };
