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
  final List<T> trips;
  final bool hasNext;

  CursorPagination({
    required this.hasNext,
    required this.trips,
  });

  CursorPagination copyWith({
    bool? hasNext,
    List<T>? trips,
  }) {
    return CursorPagination(
      hasNext: hasNext ?? this.hasNext,
      trips: trips ?? this.trips,
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
    required super.trips,
  });
}

// 리스트의 맨 아래로 내려가서
// 추가 데이터를 요청 시
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.hasNext,
    required super.trips,
  });
}
