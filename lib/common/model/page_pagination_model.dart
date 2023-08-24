import 'package:json_annotation/json_annotation.dart';

part 'page_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class PagePagination<T> {
  final PagePaginationMeta meta;
  final List<T> documents;

  PagePagination({
    required this.meta,
    required this.documents,
  });

  factory PagePagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PagePaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class PagePaginationMeta {
  final bool is_end;
  final int pageable_count;
  final int total_count;

  PagePaginationMeta({
    required this.is_end,
    required this.pageable_count,
    required this.total_count,
  });

  factory PagePaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PagePaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PagePaginationMetaToJson(this);
}
