import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  final List<T> contents;
  final bool hasNext;

  CursorPagination({
    required this.hasNext,
    required this.contents,
  });

  CursorPagination copyWith({
    bool? hasNext,
    List<T>? contents,
  }) {
    return CursorPagination(
      hasNext: hasNext ?? this.hasNext,
      contents: contents ?? this.contents,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

//새로고침시
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.hasNext,
    required super.contents,
  });
}

// 리스트의 맨 아래로 내려가서
// 추가 데이터를 요청 시
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.hasNext,
    required super.contents,
  });
}
