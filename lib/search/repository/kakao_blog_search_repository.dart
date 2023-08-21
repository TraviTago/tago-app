import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/search/model/kakao_blog_search_model.dart';
import 'package:tago_app/search/model/page_pagination_model.dart';

part 'kakao_blog_search_repository.g.dart';

final kakaoBlogSearchRepositoryProvider =
    Provider<KakaoBlogSearchRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = KakaoBlogSearchRepository(dio,
      baseUrl: "https://dapi.kakao.com/v2/search");
  return repository;
});

@RestApi()
abstract class KakaoBlogSearchRepository {
  factory KakaoBlogSearchRepository(Dio dio, {String baseUrl}) =
      _KakaoBlogSearchRepository;

  @GET('/blog')
  @Headers({
    'kakao': 'true',
  })
  Future<PagePagination<KakaoBlogSearchModel>> paginate({
    @Query('sort') String sort = 'accuracy',
    @Query('page') int page = 1,
    @Query('size') int size = 10,
    @Query('query') required String query,
  });
}
