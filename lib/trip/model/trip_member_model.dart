import 'package:json_annotation/json_annotation.dart';

part 'trip_member_model.g.dart';

@JsonSerializable()
class TripMembersList {
  final List<TripMemberModel> members;

  TripMembersList({
    required this.members,
  });
  factory TripMembersList.fromJson(Map<String, dynamic> json) =>
      _$TripMembersListFromJson(json);

  Map<String, dynamic> toJson() => _$TripMembersListToJson(this);
}

@JsonSerializable()
class TripMemberModel {
  final int memberId;
  final String imgUrl;
  final String name;
  final String mbti;
  final int ageRange;
  final String gender;
  final String tripTypes;

  TripMemberModel({
    required this.memberId,
    required this.imgUrl,
    required this.name,
    required this.mbti,
    required this.ageRange,
    required this.gender,
    required this.tripTypes,
  });

  factory TripMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TripMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripMemberModelToJson(this);
}
