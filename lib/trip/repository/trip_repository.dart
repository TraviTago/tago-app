import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';

part 'trip_repository.g.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = TripRepository(dio, baseUrl: '$ip/api/v1/trips');
  return repository;
});

@RestApi()
abstract class TripRepository {
  factory TripRepository(Dio dio, {String baseUrl}) = _TripRepository;

  @GET('')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<TripModel>> paginate({
    @Queries() PaginationParams? paginationParams,
  });

  @GET('/{tripId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripDetailModel> getDetailTrip({
    @Path() required int tripId,
  });
}
