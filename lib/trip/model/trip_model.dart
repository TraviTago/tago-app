import 'package:json_annotation/json_annotation.dart';

part 'trip_model.g.dart';

enum TripStatus {
  upcoming, // 예정된 여행
  ongoing, // 진행중인 여행
  completed // 지나간 여행
}

@JsonSerializable()
class TripModel {
  final int tripId;
  final DateTime dateTime;
  final String name;
  final String imageUrl;
  final List<String> places;
  final int maxMember; //최대 인원
  final int currentMember; //현재 인원
  final int totalTime;

  TripModel({
    required this.tripId,
    required this.dateTime,
    required this.name,
    required this.imageUrl,
    required this.places,
    required this.maxMember,
    required this.currentMember,
    required this.totalTime,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}
