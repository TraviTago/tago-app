import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_trip_model.dart';

part 'trip_edit_model.g.dart';

@JsonSerializable()
class TripEditModel {
  final List<PlaceTripModel> places;
  final String name;

  TripEditModel({
    required this.places,
    required this.name,
  });

  // copyWith 메서드를 추가합니다.
  TripEditModel copyWith({
    List<PlaceTripModel>? places,
    String? name,
  }) {
    return TripEditModel(
      places: places ?? this.places,
      name: name ?? this.name,
    );
  }

  factory TripEditModel.fromJson(Map<String, dynamic> json) =>
      _$TripEditModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripEditModelToJson(this);
}
