import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? limit;
  final int? cursorId;
  final String? cursorDate;
  final bool? sameGender;
  final bool? isPet;

  const PaginationParams({
    this.limit,
    this.cursorId,
    this.cursorDate,
    this.sameGender,
    this.isPet,
  });

  PaginationParams copyWith({
    int? limit,
    int? cursorId,
    String? cursorDate,
    bool? sameGender,
    bool? isPet,
  }) {
    return PaginationParams(
      limit: limit ?? this.limit,
      cursorId: cursorId ?? this.cursorId,
      cursorDate: cursorDate ?? this.cursorDate,
      sameGender: sameGender ?? this.sameGender,
      isPet: isPet ?? this.isPet,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
