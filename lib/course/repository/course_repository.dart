import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/course/model/course_params.dart';
import 'package:tago_app/trip/model/trip_model.dart';

part 'course_repository.g.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = CourseRepository(dio, baseUrl: '$ip/api/v1/courses');
  return repository;
});

@RestApi()
abstract class CourseRepository {
  factory CourseRepository(Dio dio, {String baseUrl}) = _CourseRepository;

  @GET('/recommend')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<TripModel>> paginate({
    @Queries() required CourseParams params,
  });
}
