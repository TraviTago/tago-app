import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/trip/model/trip_response_model.dart';
import 'package:tago_app/trip/model/trip_create_params.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/model/trip_member_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';

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

  @POST('')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripCreateResponse> createTrip({
    @Body() required TripCreateParams params,
  });

  @GET('/recommend')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripModel> getRecommendTrip();

  @GET('/{tripId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripDetailModel> getDetailTrip({
    @Path() required int tripId,
  });

  @GET('/{tripId}/status')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripStatusModel> getStatusTrip({
    @Path() required int tripId,
  });

  @GET('/{tripId}/members')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripMembersList> getMembersTrip({
    @Path() required int tripId,
  });

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<MyTripResponseModel> getMyTrips();
}
