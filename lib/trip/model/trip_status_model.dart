import 'package:json_annotation/json_annotation.dart';

part 'trip_status_model.g.dart';

@JsonSerializable()
class TripStatusModel {
  final int femaleCnt;
  final int maleCnt;
  final String meetPlace;
  final List<int> ageGroup;
  final String startTime;
  final String endTime;
  final bool pet;

  TripStatusModel({
    required this.femaleCnt,
    required this.meetPlace,
    required this.maleCnt,
    required this.ageGroup,
    required this.startTime,
    required this.endTime,
    required this.pet,
  });

  factory TripStatusModel.fromJson(Map<String, dynamic> json) =>
      _$TripStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripStatusModelToJson(this);
}
