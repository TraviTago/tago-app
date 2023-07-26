// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyModel _$PartyModelFromJson(Map<String, dynamic> json) => PartyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      maxNum: json['maxNum'] as int,
      curNum: json['curNum'] as int,
      duration: json['duration'] as int,
      startDate: json['startDate'] as int,
    );

Map<String, dynamic> _$PartyModelToJson(PartyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'tags': instance.tags,
      'maxNum': instance.maxNum,
      'curNum': instance.curNum,
      'duration': instance.duration,
      'startDate': instance.startDate,
    };
