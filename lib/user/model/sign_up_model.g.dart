// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      ageRange: json['ageRange'] as int,
      gender: json['gender'] as String,
      mbti: json['mbti'] as String,
      favorites:
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
      tripTypes:
          (json['tripTypes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'ageRange': instance.ageRange,
      'gender': instance.gender,
      'mbti': instance.mbti,
      'favorites': instance.favorites,
      'tripTypes': instance.tripTypes,
    };
