import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? limit;
  final int? cursorId;
  final String? cursorDate;

  const PaginationParams({
    this.limit,
    this.cursorId,
    this.cursorDate,
  });

  PaginationParams copyWith({
    int? limit,
    int? cursorId,
    String? cursorDate,
  }) {
    return PaginationParams(
      limit: limit ?? this.limit,
      cursorId: cursorId ?? this.cursorId,
      cursorDate: cursorDate ?? this.cursorDate,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
