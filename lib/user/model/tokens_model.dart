import 'package:json_annotation/json_annotation.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class Tokens {
  final String refreshToken;
  final String accessToken;

  Tokens({
    required this.refreshToken,
    required this.accessToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
}
