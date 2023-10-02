import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/storage/secure_storage.dart';
import 'package:tago_app/trip/model/trip_response_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final tripMeProvider =
    StateNotifierProvider<MyTripStateNotifer, MyTripResponseModel?>(
  (ref) {
    final repository = ref.watch(tripRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return MyTripStateNotifer(
      repository: repository,
      storage: storage,
    );
  },
);

class MyTripStateNotifer extends StateNotifier<MyTripResponseModel?> {
  final TripRepository repository;
  final FlutterSecureStorage storage;

  MyTripStateNotifer({
    required this.repository,
    required this.storage,
  }) : super(null);

  Future<MyTripResponseModel?> getMyTrip() async {
    try {
      // 요청을 보내는 최소 조건은 AccessToken과 RefreshToken이 존재하는 것
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      if (refreshToken == null || accessToken == null) {
        state = null;
      }

      final resp = await repository.getMyTrips();

      state = resp;

      return resp;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
