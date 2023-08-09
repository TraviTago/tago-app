import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

//유저 로딩 성공
@JsonSerializable()
class SignUpModel {
  final int ageRange;
  final String gender;
  final String mbti;
  List<String> favorites;
  List<String> tripTypes;

  SignUpModel({
    required this.ageRange,
    required this.gender,
    required this.mbti,
    required this.favorites,
    required this.tripTypes,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
