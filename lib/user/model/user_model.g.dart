// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      oauthProvider: json['oauthProvider'] as String,
      email: json['email'] as String,
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String?,
      profile: json['profile'] == null
          ? null
          : SignUpModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'oauthProvider': instance.oauthProvider,
      'email': instance.email,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'profile': instance.profile,
    };
