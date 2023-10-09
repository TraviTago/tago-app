import 'package:json_annotation/json_annotation.dart';
import 'package:tago_app/trip/model/trip_model.dart';

part 'trip_origin_model.g.dart';

@JsonSerializable()
class TripOriginModel extends TripBaseModel {
  final List<TagoTrips> tagotrips;

  TripOriginModel({
    required this.tagotrips,
  });
  factory TripOriginModel.fromJson(Map<String, dynamic> json) =>
      _$TripOriginModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripOriginModelToJson(this);
}

@JsonSerializable()
class TagoTrips {
  final String name;
  @JsonKey(name: 'img_url')
  final String imgUrl;

  TagoTrips({
    required this.name,
    required this.imgUrl,
  });

  factory TagoTrips.fromJson(Map<String, dynamic> json) =>
      _$TagoTripsFromJson(json);

  Map<String, dynamic> toJson() => _$TagoTripsToJson(this);
}
