import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/user/model/driver_user_model.dart';
import 'package:tago_app/user/model/user_model.dart';

import '../../../common/const/data.dart';

part 'user_repository.g.dart';

final userRepositoryProvier = Provider((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio, baseUrl: '$ip/api/v1');
});

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/members/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  @PATCH('/members/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> patchMe(
    @Body() Map<String, dynamic> meData,
  );

  @GET('/taxi/drivers/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<DriverUserModel> getDriverMe();
}
