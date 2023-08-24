import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'trip_detail_model.g.dart';

@JsonSerializable()
class TripDetailModel {
  final int tripId;
  final DateTime dateTime;
  final String name;
  final String imageUrl;
  final int maxMember; //최대 인원
  final int currentMember; //현재 인원
  final int totalTime;
  final List<PlaceModel> places;

  TripDetailModel({
    required this.tripId,
    required this.name,
    required this.imageUrl,
    required this.maxMember,
    required this.currentMember,
    required this.totalTime,
    required this.dateTime,
    required this.places,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailModelToJson(this);
}
