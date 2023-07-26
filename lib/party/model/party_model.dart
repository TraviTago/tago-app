import 'package:json_annotation/json_annotation.dart';

part 'party_model.g.dart';

@JsonSerializable()
class PartyModel {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> tags;
  final int maxNum; //최대 인원
  final int curNum; //현재 인원
  final int duration;
  final int startDate;

  PartyModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.tags,
    required this.maxNum,
    required this.curNum,
    required this.duration,
    required this.startDate,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) =>
      _$PartyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartyModelToJson(this);

  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //           (e) => e.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
