// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_blog_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoBlogSearchModel _$KakaoBlogSearchModelFromJson(
        Map<String, dynamic> json) =>
    KakaoBlogSearchModel(
      blogname: json['blogname'] as String,
      contents: json['contents'] as String,
      datetime: json['datetime'] as String,
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$KakaoBlogSearchModelToJson(
        KakaoBlogSearchModel instance) =>
    <String, dynamic>{
      'blogname': instance.blogname,
      'contents': instance.contents,
      'datetime': instance.datetime,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'url': instance.url,
    };
