import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'trip_create_params.g.dart';

@JsonSerializable()
class TripCreateParams {
  final String name;
  final DateTime dateTime;
  final int currentCnt;
  final int maxCnt;
  final bool sameGender;
  final bool isPet;
  final String meetPlace;
  final List<String> types;
  final List<PlaceModel> places;

  const TripCreateParams({
    required this.name,
    required this.dateTime,
    required this.currentCnt,
    required this.maxCnt,
    required this.sameGender,
    required this.isPet,
    required this.meetPlace,
    required this.types,
    required this.places,
  });

  factory TripCreateParams.fromJson(Map<String, dynamic> json) =>
      _$TripCreateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$TripCreateParamsToJson(this);
}
