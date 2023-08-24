// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagePagination<T> _$PagePaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagePagination<T>(
      meta: PagePaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PagePaginationToJson<T>(
  PagePagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents.map(toJsonT).toList(),
    };

PagePaginationMeta _$PagePaginationMetaFromJson(Map<String, dynamic> json) =>
    PagePaginationMeta(
      is_end: json['is_end'] as bool,
      pageable_count: json['pageable_count'] as int,
      total_count: json['total_count'] as int,
    );

Map<String, dynamic> _$PagePaginationMetaToJson(PagePaginationMeta instance) =>
    <String, dynamic>{
      'is_end': instance.is_end,
      'pageable_count': instance.pageable_count,
      'total_count': instance.total_count,
    };
