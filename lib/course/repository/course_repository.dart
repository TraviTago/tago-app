import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/course/model/course_reponse_model.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = CourseRepository(dio: dio, baseUrl: '$ip/api/v1/courses');
  return repository;
});

class CourseRepository {
  final String baseUrl;
  final Dio dio;

  CourseRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<CourseResponseModel> recommendCourse({
    required int? placeId,
    required List<String> tags,
  }) async {
    final resp = await dio.request(
      '$baseUrl/recommend',
      queryParameters: {'placeId': placeId, 'tags': tags},
      options: Options(
        method: HttpMethod.GET,
        headers: {
          'accessToken': 'true',
        },
      ),
    );

    return CourseResponseModel.fromJson(
      resp.data,
    );
  }
}
