import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/dio/dio.dart';

final customerServiceRepositoryProvider =
    Provider<CustomerServiceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CustomerServiceRepository(baseUrl: '$ip/api/v1', dio: dio);
});

class CustomerServiceRepository {
  final String baseUrl;
  final Dio dio;

  CustomerServiceRepository({
    required this.baseUrl,
    required this.dio,
  });
  Future report({
    required String type,
    required String detail,
  }) async {
    final resp = await dio.post(
      '$baseUrl/report',
      data: {
        'type': type,
        'detail': detail,
      },
      options: Options(
        headers: {
          'accessToken': 'true',
        },
      ),
    );

    return resp;
  }
}
