import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/login/model/login_response.dart';
import 'package:tago_app/signup/model/sign_up_response.dart';
import 'package:tago_app/user/model/token_response.dart';

import '../../../common/const/data.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: '$ip/api/v1/auth', dio: dio);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String oauthProvider,
    required String email,
    required String? name,
  }) async {
    final resp = await dio.post(
      '$baseUrl/login',
      data: {
        'oauthProvider': oauthProvider,
        'email': email,
        'name': name,
      },
    );

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<SignUpResponse> signUp({
    required int ageRange,
    required String gender,
    required String mbti,
    required List<String> favorites,
    required List<String> tripTypes,
  }) async {
    final resp = await dio.patch(
      '$baseUrl/sign-up',
      data: {
        'ageRange': ageRange,
        'gender': gender,
        'mbti': mbti,
        'favorites': favorites,
        'tripTypes': tripTypes,
      },
      options: Options(
        headers: {
          'accessToken': 'true',
        },
      ),
    );

    return SignUpResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token/reissue',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );

    return TokenResponse.fromJson(
      resp.data,
    );
  }
}
