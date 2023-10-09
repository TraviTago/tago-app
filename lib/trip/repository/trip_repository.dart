import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/trip/model/trip_detail_driver_model.dart';
import 'package:tago_app/trip/model/trip_driver_info_model.dart';
import 'package:tago_app/trip/model/trip_origin_model.dart';
import 'package:tago_app/trip/model/trip_response_model.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/model/trip_member_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/model/trip_status_model.dart';

part 'trip_repository.g.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = TripRepository(dio, baseUrl: '$ip/api/v1');
  return repository;
});

@RestApi()
abstract class TripRepository {
  factory TripRepository(Dio dio, {String baseUrl}) = _TripRepository;

  @GET('/trips')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<TripModel>> paginate({
    @Queries() PaginationParams? paginationParams,
  });

  @GET('/taxi/trips')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<TripModel>> paginateDriverTrip({
    @Queries() PaginationParams? paginationParams,
  });

  @POST('/trips')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripCreateResponse> createTrip(
    @Body() Map<String, dynamic> tripData,
  );

  @GET('/trips/recommend')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripModel> getRecommendTrip();

  @GET('/trips/{tripId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripDetailModel> getDetailTrip({
    @Path() required int tripId,
  });

  @GET('/taxi/trips/{tripId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripDetailDriverModel> getDetailTripDriver({
    @Path() required int tripId,
  });

  @POST('/taxi/trips/{tripId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> postDetailTripDriver({
    @Path() required int tripId,
    @Query('state') required String state,
  });

  @GET('/trips/{tripId}/status')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripStatusModel> getStatusTrip({
    @Path() required int tripId,
  });

  @POST('/trips/{tripId}/join')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> joinTrip({
    @Path() required int tripId,
  });

  @DELETE('/trips/{tripId}/leave')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> leaveTrip({
    @Path() required int tripId,
  });

  @GET('/trips/{tripId}/members')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripMembersList> getMembersTrip({
    @Path() required int tripId,
  });

  @GET('/taxi/trips/{tripId}/members')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripMembersList> getMembersTripDriver({
    @Path() required int tripId,
  });

  @GET('/taxi/trips/{tripId}/driver')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripDriverInfoModel> getDriverTrip({
    @Path() required int tripId,
  });

  @GET('/trips/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<MyTripResponseModel> getMyTrips();

  @GET('/taxi/trips/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<MyTripResponseModel> getMyDriverTrips();

  @GET('/trips/origin')
  @Headers({
    'accessToken': 'true',
  })
  Future<TripOriginModel> getTagoOriginTrips();
}
