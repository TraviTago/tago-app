// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      limit: json['limit'] as int?,
      cursorId: json['cursorId'] as int?,
      cursorDate: json['cursorDate'] as String?,
      sameGender: json['sameGender'] as bool?,
      isPet: json['isPet'] as bool?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'cursorId': instance.cursorId,
      'cursorDate': instance.cursorDate,
      'sameGender': instance.sameGender,
      'isPet': instance.isPet,
    };
