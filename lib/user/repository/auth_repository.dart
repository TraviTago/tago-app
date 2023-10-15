import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/dio/dio.dart';
import 'package:tago_app/login/model/login_response.dart';
import 'package:tago_app/signup/model/sign_up_response.dart';
import 'package:tago_app/user/model/sms_model.dart';
import 'package:tago_app/user/model/token_response.dart';

import '../../../common/const/data.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: '$ip/api/v1', dio: dio);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String number,
  }) async {
    final resp = await dio.post(
      '$baseUrl/auth/login',
      data: {
        'number': number,
        'firebaseToken': await FirebaseMessaging.instance.getToken(),
      },
    );
    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<LoginResponse> driverLogin({
    required String code,
  }) async {
    final resp = await dio.post(
      '$baseUrl/taxi/auth/login',
      data: {
        'code': code,
      },
    );
    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<dynamic> smsSending({
    required String number,
  }) async {
    final resp = await dio.post(
      '$baseUrl/auth/sms',
      data: {
        'number': number,
      },
    );
    return resp;
  }

  Future<SmsVerifyResponse> smsVerify({
    required String number,
    required String code,
  }) async {
    final resp = await dio.post(
      '$baseUrl/auth/sms/verify-code',
      data: {
        'number': number,
        'code': code,
      },
    );
    return SmsVerifyResponse.fromJson(
      resp.data,
    );
  }

  Future<SignUpResponse> signUp({
    required String number,
    required String name,
    required String imgUrl,
    required int ageRange,
    required String gender,
    required String mbti,
    required List<String> favorites,
    required List<String> tripTypes,
  }) async {
    final resp = await dio.post(
      '$baseUrl/auth/sign-up',
      data: {
        'number': number,
        'imgUrl': imgUrl,
        'name': name,
        'ageRange': ageRange,
        'gender': gender,
        'mbti': mbti,
        'favorites': favorites,
        'tripTypes': tripTypes,
        'firebaseToken': await FirebaseMessaging.instance.getToken(),
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
      '$baseUrl/auth/token/reissue',
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
