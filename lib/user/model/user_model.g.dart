// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      number: json['number'] as String,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      ageRange: json['ageRange'] as int,
      gender: json['gender'] as String,
      mbti: json['mbti'] as String,
      favorites:
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
      tripTypes:
          (json['tripTypes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'number': instance.number,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'ageRange': instance.ageRange,
      'gender': instance.gender,
      'mbti': instance.mbti,
      'favorites': instance.favorites,
      'tripTypes': instance.tripTypes,
    };
