import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/place/model/place_detail_model.dart';

part 'place_repository.g.dart';

final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = PlaceRepository(dio, baseUrl: '$ip/api/v1/place');
  return repository;
});

@RestApi()
abstract class PlaceRepository {
  factory PlaceRepository(Dio dio, {String baseUrl}) = _PlaceRepository;

  @GET('/{placeId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PlaceDetailModel> getDetailPlace({
    @Path() required int placeId,
  });
}
