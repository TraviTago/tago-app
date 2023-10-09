// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripMembersList _$TripMembersListFromJson(Map<String, dynamic> json) =>
    TripMembersList(
      members: (json['members'] as List<dynamic>)
          .map((e) => TripMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripMembersListToJson(TripMembersList instance) =>
    <String, dynamic>{
      'members': instance.members,
    };

TripMemberModel _$TripMemberModelFromJson(Map<String, dynamic> json) =>
    TripMemberModel(
      memberId: json['memberId'] as int,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      mbti: json['mbti'] as String,
      ageRange: json['ageRange'] as int,
      gender: json['gender'] as String,
      tripTypes: json['tripTypes'] as String,
      phone_number: json['phone_number'] as String?,
    );

Map<String, dynamic> _$TripMemberModelToJson(TripMemberModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'mbti': instance.mbti,
      'ageRange': instance.ageRange,
      'gender': instance.gender,
      'tripTypes': instance.tripTypes,
      'phone_number': instance.phone_number,
    };
