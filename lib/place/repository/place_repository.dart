import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/place/model/place_detail_model.dart';
import 'package:tago_app/place/model/place_model.dart';

part 'place_repository.g.dart';

final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = PlaceRepository(dio, baseUrl: '$ip/api/v1');
  return repository;
});

@RestApi()
abstract class PlaceRepository {
  factory PlaceRepository(Dio dio, {String baseUrl}) = _PlaceRepository;

  @GET('/places')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<PlaceModel>> getPlaces({
    @Queries() PaginationParams? paginationParams,
  });

  @GET('/place/{placeId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PlaceDetailModel> getDetailPlace({
    @Path() required int placeId,
  });

  @GET('/places/recommend')
  @Headers({
    'accessToken': 'true',
  })
  Future<PlaceListModel> getRecommendPlaces();

  @GET('/places/popular')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<PlaceModel>> getPopularPlaces();
}
