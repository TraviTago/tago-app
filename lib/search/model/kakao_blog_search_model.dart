import 'package:json_annotation/json_annotation.dart';

part 'kakao_blog_search_model.g.dart';

@JsonSerializable()
class KakaoBlogSearchModel {
  final String blogname;
  final String contents;
  final String datetime;
  final String thumbnail;
  final String title;
  final String url;

  KakaoBlogSearchModel({
    required this.blogname,
    required this.contents,
    required this.datetime,
    required this.thumbnail,
    required this.title,
    required this.url,
  });

  factory KakaoBlogSearchModel.fromJson(Map<String, dynamic> json) =>
      _$KakaoBlogSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$KakaoBlogSearchModelToJson(this);
}
